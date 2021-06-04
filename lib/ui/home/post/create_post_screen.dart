import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:sevgram/components/buttons/primary_button.dart';
import 'package:sevgram/components/commons/card_image_picker.dart';
import 'package:sevgram/components/commons/default_appbar.dart';
import 'package:sevgram/components/commons/flat_card.dart';
import 'package:sevgram/components/dialog/custom_alert_dialog.dart';
import 'package:sevgram/components/textareas/password_textarea.dart';
import 'package:sevgram/components/textareas/textarea.dart';
import 'package:sevgram/data/providers/post_provider.dart';
import 'package:sevgram/data/providers/token_provider.dart';
import 'package:sevgram/data/providers/user_provider.dart';
import 'package:sevgram/data/services/api_interface.dart';
import 'package:sevgram/data/services/entities/default_response.dart';
import 'package:sevgram/data/services/entities/login_response.dart';
import 'package:sevgram/ui/home/home_screen.dart';
import 'package:sevgram/ui/register/register_screen.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/tools.dart';
import 'package:sevgram/utils/widget_helper.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController captionController = TextEditingController();
  bool enableButton = false;
  ApiInterface apiInterface;
  List<File> selectedImages = [];
  bool isTurnOffComment = false;
  bool hideLikeAndView = false;

  void addPost() {
    Map<String, String> files = HashMap();
    Map<String, String> headers = HashMap();
    Map<String, String> body = HashMap();
    body["text"] = captionController.text;
    files["image"] = selectedImages[0].path;
    headers["Authorization"] = "Bearer " + context.read<TokenProvider>().token;
    headers["Content-Type"] = "multipart/form-data";
    body["is_turn_of_comment"] = isTurnOffComment ? "1" : "0";
    body["is_turn_of_like"] = hideLikeAndView ? "1" : "0";
    apiInterface.addPost(
      body: body,
      header: headers,
      files: files,
      onFinish: (response) async {
        Navigator.pop(context);
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        DefaultResponse defaultResponse =
            DefaultResponse.fromJson(json.decode(responseString));
        if (response.statusCode == 200) {
          for (String path in files.values) {
            if (File(path).existsSync()) {
              File(path).deleteSync();
            }
          }
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

  void onTextChange() {
    setState(() {
      enableButton =
          captionController.text.isNotEmpty && selectedImages.length > 0;
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      apiInterface = ApiInterface(context);
    });

    captionController.addListener(onTextChange);

    Tools.changeStatusbarIconColor(
      darkIcon: true,
      statusBarColor: Themes.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    User user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: DefaultAppBar(
        height: 66.h(),
        title: "Add Post",
        action: Builder(builder: (context) {
          return Container(
            width: 24.w(),
            height: 24.w(),
            decoration: BoxDecoration(
              color: Themes.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                user != null ? user.fullname.substring(0, 1).toUpperCase() : "",
                style: Themes().whiteBold16,
              ),
            ),
          );
        }),
      ),
      body: Container(
        height: 100.hp(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardImagePicker(
                    onImagePicked: (List<File> images) {
                      setState(() {
                        selectedImages = images;
                        onTextChange();
                      });
                    },
                  ).addMarginTop(4.h()),
                ],
              ).addSymmetricMargin(
                vertical: 18.h(),
              ),
              TextArea(
                controller: captionController,
                hint: "Write a caption",
              ).addMarginTop(14.h()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Turn off comment",
                    style: Themes().gray14,
                  ),
                  Switch(
                    value: isTurnOffComment,
                    onChanged: (bool newValue) {
                      setState(() {
                        isTurnOffComment = newValue;
                      });
                    },
                  ),
                ],
              ).addSymmetricMargin(
                horizontal: 4.h(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hide Like And View Count",
                    style: Themes().gray14,
                  ),
                  Switch(
                    value: hideLikeAndView,
                    onChanged: (bool newValue) {
                      setState(() {
                        hideLikeAndView = newValue;
                      });
                    },
                  )
                ],
              ).addSymmetricMargin(
                horizontal: 4.h(),
              ),
              PrimaryButton(
                enable: enableButton,
                onTap: () {
                  Tools.showProgressDialog(context);
                  addPost();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Post",
                      style: Themes().white14,
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Themes.white,
                    ),
                  ],
                ),
              ).addMarginTop(14.h()),
            ],
          ).addAllPadding(18.w()),
        ),
      ),
    );
  }
}
