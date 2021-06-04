import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sevgram/components/items/item_post.dart';
import 'package:sevgram/data/providers/post_provider.dart';
import 'package:sevgram/data/services/entities/posts_response.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().getPosts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Post> posts = context.watch<PostProvider>().posts;
    bool loading = context.watch<PostProvider>().loading;
    RefreshController refreshController =
        context.watch<PostProvider>().refreshController;

    return Scaffold(
      backgroundColor: Colors.white,
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SmartRefresher(
              controller: refreshController,
              header: ClassicHeader(
                idleText: "Pull to refresh",
                refreshingText: "Refreshing",
                releaseText: "Release",
                completeText: "",
              ),
              footer: ClassicFooter(
                idleIcon: null,
                idleText: "",
                noDataText: "",
                loadingText: "Memuat",
              ),
              onRefresh: () {
                context.read<PostProvider>().getPosts(context);
              },
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  Post post = posts[index];

                  return ItemPost(
                    onTapAddComment: () {},
                    onTapComment: () {},
                    post: post,
                  );
                },
              ),
            ),
    );
  }
}
