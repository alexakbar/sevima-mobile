import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sevgram/components/items/item_post.dart';
import 'package:sevgram/data/providers/post_provider.dart';
import 'package:sevgram/data/providers/user_provider.dart';
import 'package:sevgram/data/services/entities/login_response.dart';
import 'package:sevgram/data/services/entities/posts_response.dart';
import 'package:sevgram/ui/comment/comment_screen.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/tools.dart';
import 'package:sevgram/utils/widget_helper.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() { 
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().getMyPost(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = context.watch<UserProvider>().user;
    List<Post> posts = context.watch<PostProvider>().myPosts;
    bool loading = context.watch<PostProvider>().loadingMypost;
    RefreshController refreshController =
        context.watch<PostProvider>().refreshMypostController;
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
                context.read<PostProvider>().getMyPost(context);
              },
              child: 
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      Post post = posts[index];

                      return ItemPost(
                        onTapAddComment: () {
                          Tools.navigatePush(
                            context,
                            CommentScreen(
                              post: post,
                              autofocus: true,
                            ),
                          );
                        },
                        onTapComment: () {
                          Tools.navigatePush(
                            context,
                            CommentScreen(
                              post: post,
                            ),
                          );
                        },
                        post: post,
                      );
                    },
                  
                
              )
            ),
    );
  }
}
