import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:sevgram/components/buttons/ripple_button.dart';
import 'package:sevgram/components/commons/line.dart';
import 'package:sevgram/components/dialog/question_dialog.dart';
import 'package:sevgram/data/providers/token_provider.dart';
import 'package:sevgram/data/providers/user_provider.dart';
import 'package:sevgram/data/services/entities/login_response.dart';
import 'package:sevgram/r.dart';
import 'package:sevgram/ui/home/pages/home_page.dart';
import 'package:sevgram/ui/home/pages/profile_page.dart';
import 'package:sevgram/ui/login/login_screen.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/tools.dart';
import 'package:sevgram/utils/widget_helper.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadLocalUser();
      context.read<UserProvider>().loadNetworkUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = context.watch<UserProvider>().user;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [
              Builder(builder: (context) {
                return Container(
                  width: 34.w(),
                  height: 34.w(),
                  decoration: BoxDecoration(
                    color: Themes.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      user != null
                          ? user.fullname.substring(0, 1).toUpperCase()
                          : "",
                      style: Themes().whiteBold16,
                    ),
                  ),
                ).addMarginTop(24.h()).onTap(() {
                  Scaffold.of(context).openDrawer();
                });
              }),
            ],
          ).addAllPadding(14.w()),
          Line(),
          PageView(
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            controller: pageController,
            children: [
              HomePage(),
              ProfilePage(),
            ],
          ).addExpanded,
          Line(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RippleButton(
                padding: EdgeInsets.all(8.w()),
                onTap: () {
                  pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeIn,
                  );
                },
                child: Icon(
                  Icons.home_rounded,
                  size: 24.f(),
                  color: currentIndex == 0
                      ? Themes.primary
                      : Themes.black.withOpacity(0.3),
                ),
              ),
              RippleButton(
                border: Border.all(color: Themes.primary),
                color: Themes.white,
                padding: EdgeInsets.all(8.w()),
                onTap: () {},
                child: Icon(
                  Icons.add_rounded,
                  size: 24.f(),
                  color: Themes.primary,
                ),
              ),
              RippleButton(
                padding: EdgeInsets.all(8.w()),
                onTap: () {
                  pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeIn,
                  );
                },
                child: Icon(
                  Icons.account_box_rounded,
                  size: 24.f(),
                  color: currentIndex == 1
                      ? Themes.primary
                      : Themes.black.withOpacity(0.3),
                ),
              ),
            ],
          ).addAllPadding(8.w())
        ],
      ),
      drawer: Container(
        width: 80.wp(),
        height: 100.hp(),
        color: Themes.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 68.w(),
              height: 68.w(),
              decoration: BoxDecoration(
                color: Themes.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  user != null
                      ? user.fullname.substring(0, 1).toUpperCase()
                      : "",
                  style: Themes().whiteBold32,
                ),
              ),
            ).addMarginOnly(
              top: 32.h(),
              left: 14.w(),
            ),
            Text(
              user != null ? user.fullname : "",
              style: Themes().blackBold18,
            ).addMarginOnly(
              top: 14.h(),
              left: 14.w(),
            ),
            Text(
              user != null ? "@" + user.username : "",
              style: Themes().gray14,
            ).addMarginLeft(14.w()),
            Line().addMarginTop(14.h()),
            RippleButton(
              radius: 0,
              onTap: () {
                Navigator.pop(context);
                Tools.showCustomDialog(
                  context,
                  child: QuestionDialog(
                    title: "Sign out",
                    message: "Are you sure want to sign out from this account?",
                    positiveText: "Sign out",
                    negativeText: "Cancel",
                    negativeAction: true,
                    onConfirm: () {
                      Navigator.pop(context);
                      context.read<UserProvider>().logoutUser();
                      context.read<TokenProvider>().resetToken();
                      Tools.navigateRefresh(context, LoginScreen(), "/login");
                    },
                    onCancel: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sign out",
                    style: Themes().primaryBold14.withColor(Themes.red),
                  ),
                  Icon(
                    Icons.exit_to_app_rounded,
                    size: 20.f(),
                    color: Themes.red,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
