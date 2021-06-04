import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sevgram/data/providers/token_provider.dart';
import 'package:sevgram/data/services/api_interface.dart';
import 'package:sevgram/data/services/entities/post_response.dart';
import 'package:sevgram/data/services/entities/posts_response.dart';

class PostProvider with ChangeNotifier {
  bool loading = true;
  List<Post> posts = [];
  ApiInterface apiInterface;
  RefreshController refreshController = RefreshController();

  void incrementLike(Post post) {
    int index = posts.indexOf(post);

    posts[index].totalLike++;
    posts[index].isLike = true;
    notifyListeners();
  }

  void decrementLike(Post post) {
    int index = posts.indexOf(post);

    posts[index].totalLike--;
    posts[index].isLike = false;
    notifyListeners();
  }

  void likePost(
    BuildContext context,
    Post post, {
    bool reset = true,
    VoidCallback onFinish,
  }) {
    if (apiInterface == null) apiInterface = ApiInterface(context);

    Map<String, String> headers = Map();
    Map<String, String> body = Map();

    headers["Authorization"] = "Bearer " + context.read<TokenProvider>().token;
    body["post_id"] = post.id.toString();

    apiInterface.doLikePost(
      body: body,
      header: headers,
      onFinish: (response) {
        if (response.statusCode == 200) {
          updateLatestPost(context, post);
          if (reset) {
            if (onFinish != null) onFinish();
          }
        }
      },
    );
  }

  void unlikePost(
    BuildContext context,
    Post post, {
    bool reset = true,
    VoidCallback onFinish,
  }) {
    if (apiInterface == null) apiInterface = ApiInterface(context);

    Map<String, String> headers = Map();
    Map<String, String> body = Map();

    headers["Authorization"] = "Bearer " + context.read<TokenProvider>().token;
    body["post_id"] = post.id.toString();

    apiInterface.doUnlikePost(
      body: body,
      header: headers,
      onFinish: (response) {
        if (response.statusCode == 200) {
          updateLatestPost(context, post);
          if (reset) {
            if (onFinish != null) onFinish();
          }
        }
      },
    );
  }

  void updateLatestPost(
    BuildContext context,
    Post post, {
    bool reset = true,
    VoidCallback onFinish,
  }) {
    if (apiInterface == null) apiInterface = ApiInterface(context);

    Map<String, String> headers = Map();
    headers["Authorization"] = "Bearer " + context.read<TokenProvider>().token;

    apiInterface.doGetPostById(
      id: post.id,
      header: headers,
      onFinish: (response) {
        PostResponse postResponse =
            PostResponse.fromJson(jsonDecode(response.body));

        if (response.statusCode == 200) {
          int index = posts.indexOf(post);
          posts[index] = postResponse.data;

          notifyListeners();
          if (reset) {
            if (onFinish != null) onFinish();
          }
        }
      },
    );
  }

  void getPosts(
    BuildContext context, {
    bool reset = true,
    VoidCallback onFinish,
  }) {
    if (apiInterface == null) apiInterface = ApiInterface(context);

    Map<String, String> headers = Map();
    headers["Authorization"] = "Bearer " + context.read<TokenProvider>().token;

    apiInterface.doGetPosts(
      header: headers,
      onFinish: (response) {
        refreshController.loadComplete();
        refreshController.refreshCompleted();

        loading = false;

        PostsResponse postsResponse =
            PostsResponse.fromJson(jsonDecode(response.body));

        if (response.statusCode == 200) {
          posts.clear();
          posts.addAll(postsResponse.data);
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
