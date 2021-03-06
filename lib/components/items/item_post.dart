import 'dart:collection';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sevgram/components/buttons/ripple_button.dart';
import 'package:sevgram/components/commons/flat_card.dart';
import 'package:sevgram/components/commons/line.dart';
import 'package:sevgram/components/commons/popup_menu.dart';
import 'package:sevgram/components/dialog/custom_alert_dialog.dart';
import 'package:sevgram/components/dialog/question_dialog.dart';
import 'package:sevgram/data/providers/post_provider.dart';
import 'package:sevgram/data/providers/token_provider.dart';
import 'package:sevgram/data/providers/user_provider.dart';
import 'package:sevgram/data/services/api_interface.dart';
import 'package:sevgram/data/services/api_service.dart';
import 'package:sevgram/data/services/entities/default_response.dart';
import 'package:sevgram/data/services/entities/login_response.dart';
import 'package:sevgram/data/services/entities/posts_response.dart';
import 'package:sevgram/r.dart';
import 'package:sevgram/ui/home/post/create_post_screen.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/tools.dart';
import 'package:sevgram/utils/widget_helper.dart';

class ItemPost extends StatefulWidget {
  final Post post;
  final VoidCallback onTapComment;
  final VoidCallback onTapAddComment;

  ItemPost({
    Key key,
    @required this.post,
    @required this.onTapComment,
    @required this.onTapAddComment,
  }) : super(key: key);

  @override
  _ItemPostState createState() => _ItemPostState();
}

class _ItemPostState extends State<ItemPost> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double opacity = 0;
  ApiInterface apiInterface;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this, value: 0);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      apiInterface = ApiInterface(context);
    });
  }

  void deletePost() {
    Map<String, String> headers = HashMap();
    Map<String, String> body = HashMap();
    headers["Authorization"] = "Bearer " + context.read<TokenProvider>().token;

    apiInterface.deletePost(
      id: widget.post.id,
      body: body,
      header: headers,
      onFinish: (response) async {
        Navigator.pop(context);

        DefaultResponse defaultResponse =
            DefaultResponse.fromJson(jsonDecode(response.body));
        if (response.statusCode == 200) {
          context.read<PostProvider>().getPosts(context);
          await showDialog<String>(
            barrierDismissible: false,
            context: context,
            builder: (context) => CustomAlertDialog(
              title: "Success",
              message: defaultResponse.message,
              buttonText: "OK",
              onConfirm: () {
                Navigator.pop(context);
              },
            ),
          ).then((v) {
            Navigator.pop(context);
          });
        } else {
          Navigator.pop(context);
          Tools.showCustomDialog(
            context,
            child: CustomAlertDialog(
              title: "Error",
              message: defaultResponse.message,
              buttonText: "Dismiss",
              onConfirm: () {
                Navigator.pop(context);
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    User user = context.watch<UserProvider>().user;

    return Column(
      children: [
        RippleButton(
          radius: 0,
          onTap: widget.post.isTurnOfComment == 0 ? widget.onTapComment : () {},
          padding: EdgeInsets.all(14.w()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32.w(),
                        height: 32.w(),
                        decoration: BoxDecoration(
                          color: Themes.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            widget.post.user.fullname
                                .substring(0, 1)
                                .toUpperCase(),
                            style: Themes().whiteBold18,
                          ),
                        ),
                      ),
                      Text(
                        widget.post.user.fullname,
                        style: Themes().blackBold16,
                      ).addMarginLeft(6.w()),
                      Text(
                        "@${widget.post.user.username}",
                        style: Themes().gray14,
                      ).addMarginLeft(6.w()),
                      Expanded(child: Container()),
                      if (widget.post.user.id == user.id)
                        PopupMenu(
                          icon: Icons.more_horiz_rounded,
                          menus: [
                            MenuItem(
                              text: "Edit",
                              value: "edit",
                            ),
                            MenuItem(
                              text: "Delete",
                              value: "delete",
                            ),
                          ],
                          onSelected: (value) {
                            switch (value) {
                              case "edit":
                                Tools.navigatePush(
                                    context,
                                    CreatePostScreen(
                                      post: widget.post,
                                    ));
                                break;

                              case "delete":
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) => QuestionDialog(
                                    title: "Delete your post",
                                    message: "Are you sure?",
                                    positiveText: "Delete",
                                    negativeText: "Cancel",
                                    negativeAction: true,
                                    onConfirm: () {
                                      Tools.showProgressDialog(context);

                                      deletePost();
                                    },
                                    onCancel: () {
                                      Navigator.pop(context, false);
                                    },
                                  ),
                                );
                                break;
                            }
                          },
                        ),
                    ],
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onDoubleTap: () {
                          doLike(context);

                          _controller.forward();
                          setState(() {
                            opacity = 1;
                          });

                          Future.delayed(Duration(milliseconds: 1000), () {
                            _controller.reverse();
                            setState(() {
                              opacity = 0;
                            });
                          });

                          // if (!widget.post.isLoved) {
                          //     doLovePost(token, widget.post.id.toString());
                          //   }
                        },
                        child: FlatCard(
                          borderRadius: BorderRadius.circular(8.w()),
                          color: Themes.stroke,
                          width: double.infinity,
                          height: 240.h(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.w()),
                            child: CachedNetworkImage(
                              imageUrl: ApiService.imageUrl + widget.post.image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return Image.asset(
                                  AssetImages.placeholder,
                                  width: double.infinity,
                                  height: 240.h(),
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 240.h(),
                        child: Center(
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 200),
                            opacity: opacity / 1.5,
                            child: ScaleTransition(
                              scale: _animation,
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                AssetIcons.tapLove,
                                width: 200.w(),
                                height: 200.w(),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).addSymmetricMargin(vertical: 12.h()),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.post.isTurnOfComment == 0)
                        SvgPicture.asset(
                          AssetIcons.icComment,
                          width: 18.w(),
                          height: 18.w(),
                        ),
                      SvgPicture.asset(
                        widget.post.isLike
                            ? AssetIcons.icLoveFilled
                            : AssetIcons.icLove,
                        width: 18.w(),
                        height: 18.w(),
                        color: widget.post.isLike ? Themes.red : null,
                      )
                          .addMarginLeft(
                              widget.post.isTurnOfComment == 0 ? 6.w() : 6)
                          .onTap(() {
                        doLike(context);
                      }),
                    ],
                  ),
                  if (widget.post.likers.length > 10)
                    Text(
                      "Liked by " +
                          (widget.post.likers.first.id == user.id
                              ? "You"
                              : widget.post.likers.first.fullname) +
                          " and " +
                          (widget.post.totalLike - 1).toString() +
                          " others",
                      style: Themes().blackBold12,
                    ).addMarginTop(6.h())
                  else if (widget.post.isTurnOfLike == 0)
                    Text(
                      widget.post.totalLike.toString() + " Likes",
                      style: Themes().blackBold12,
                    ).addMarginTop(6.h()),
                  Text(
                    widget.post.text,
                    style: Themes(withLineHeight: true).black14,
                  ).addMarginTop(6.h()),
                  if (widget.post.totalComment > 0)
                    Text(
                      "See all ${widget.post.totalComment} comments",
                      style: Themes().gray14,
                    ),
                  if (widget.post.totalComment > 0)
                    Column(
                      children: (widget.post.comment.length > 3
                              ? widget.post.comment.sublist(0, 3)
                              : widget.post.comment)
                          .map((comment) {
                        return Row(
                          children: [
                            Text(
                              comment.user.fullname,
                              style: Themes().blackBold14,
                            ),
                            Text(
                              comment.text,
                              style: Themes().black14,
                            ).addMarginLeft(6.w()),
                          ],
                        );
                      }).toList(),
                    ),
                  if (widget.post.isTurnOfComment == 0)
                    Row(
                      children: [
                        Container(
                          width: 24.w(),
                          height: 24.w(),
                          decoration: BoxDecoration(
                            color: Themes.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              user.fullname.substring(0, 1).toUpperCase(),
                              style: Themes().whiteBold14,
                            ),
                          ),
                        ),
                        Text(
                          "Write Comment...",
                          style: Themes().gray14,
                        ).onTap(() {
                          widget.onTapAddComment();
                        }).addMarginLeft(6.w()),
                      ],
                    ).addMarginTop(6.h()),
                ],
              ).addFlexible,
            ],
          ),
        ),
        Line(),
      ],
    );
  }

  void doLike(BuildContext context) {
    if (!widget.post.isLike) {
      context.read<PostProvider>().incrementLike(widget.post);
      context.read<PostProvider>().likePost(context, widget.post);
    } else {
      context.read<PostProvider>().decrementLike(widget.post);
      context.read<PostProvider>().unlikePost(context, widget.post);
    }
  }
}
