import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:sevgram/components/buttons/ripple_button.dart';
import 'package:sevgram/components/commons/default_appbar.dart';
import 'package:sevgram/components/commons/flat_card.dart';
import 'package:sevgram/components/commons/line.dart';
import 'package:sevgram/components/items/item_comment.dart';
import 'package:sevgram/components/textareas/textarea.dart';
import 'package:sevgram/data/providers/comment_provider.dart';
import 'package:sevgram/data/providers/post_provider.dart';
import 'package:sevgram/data/providers/token_provider.dart';
import 'package:sevgram/data/providers/user_provider.dart';
import 'package:sevgram/data/services/api_interface.dart';
import 'package:sevgram/data/services/entities/login_response.dart';
import 'package:sevgram/data/services/entities/posts_response.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/tools.dart';
import 'package:sevgram/utils/widget_helper.dart';

class CommentScreen extends StatefulWidget {
  final Post post;
  final bool autofocus;

  CommentScreen({
    Key key,
    this.post,
    this.autofocus = false,
  }) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController textareaController = TextEditingController();
  ApiInterface apiInterface;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      apiInterface = ApiInterface(context);
      context.read<CommentProvider>().getComments(widget.post.id, context);
    });
  }

  void doCreateComment() {
    Map<String, String> headers = Map();
    Map<String, String> body = Map();

    headers["Authorization"] = "Bearer " + context.read<TokenProvider>().token;
    body["text"] = textareaController.text;
    body["post_id"] = widget.post.id.toString();

    apiInterface.createComment(
      header: headers,
      body: body,
      onFinish: (response) {
        Navigator.pop(context);

        if (response.statusCode == 200) {
          User user = context.read<UserProvider>().user;

          Comment comment = Comment(
            user: user,
            userId: user.id,
            postId: widget.post.id,
            text: textareaController.text,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          context.read<CommentProvider>().addComment(comment);
          context.read<CommentProvider>().getComments(widget.post.id, context);

          setState(() {
            textareaController.text = "";
          });
          context.read<PostProvider>().updateLatestPost(context, widget.post);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Comment> comments = context.watch<CommentProvider>().comments;
    bool loading = context.watch<CommentProvider>().loading;

    return Scaffold(
      appBar: DefaultAppBar(
        height: 68.h(),
        title: "Comments",
      ),
      body: Column(
        children: [
          loading
              ? Center(child: CircularProgressIndicator()).addExpanded
              : ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    Comment comment = comments[index];

                    return ItemComment(comment: comment);
                  },
                ).addExpanded,
          Line(),
          FlatCard(
            padding: EdgeInsets.all(14.w()),
            color: Themes.white,
            child: TextArea(
              autoFocus: widget.autofocus,
              controller: textareaController,
              hint: "write your comment here",
              textInputAction: TextInputAction.send,
              onSubmitText: (text) {
                Tools.showProgressDialog(context);
                doCreateComment();
              },
            ),
          ),
        ],
      ),
    );
  }
}
