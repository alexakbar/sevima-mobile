import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sevgram/data/providers/token_provider.dart';
import 'package:sevgram/data/services/api_interface.dart';
import 'package:sevgram/data/services/entities/comment_response.dart';
import 'package:sevgram/data/services/entities/posts_response.dart';

class CommentProvider with ChangeNotifier {
  bool loading = true;
  List<Comment> comments = [];
  ApiInterface apiInterface;
  RefreshController refreshController = RefreshController();

  void addComment(Comment comment) {
    comments.add(comment);
    notifyListeners();
  }

  void getComments(
    int id,
    BuildContext context, {
    bool reset = true,
    VoidCallback onFinish,
  }) {
    loading = true;
    comments.clear();
    notifyListeners();
    if (apiInterface == null) apiInterface = ApiInterface(context);

    Map<String, String> headers = Map();
    Map<String, String> body = Map();

    headers["Authorization"] = "Bearer " + context.read<TokenProvider>().token;
    body["post_id"] = id.toString();

    apiInterface.getComments(
      body: body,
      header: headers,
      onFinish: (response) {
        refreshController.loadComplete();
        refreshController.refreshCompleted();

        loading = false;

        CommentResponse commentResponse =
            CommentResponse.fromJson(jsonDecode(response.body));

        if (response.statusCode == 200) {
          comments.clear();
          comments.addAll(commentResponse.data);
          notifyListeners();
          if (reset) {
            if (onFinish != null) onFinish();
          }
        }
      },
      onUnhandleError: (error, response) {
        print(error);
      },
    );
  }
}
