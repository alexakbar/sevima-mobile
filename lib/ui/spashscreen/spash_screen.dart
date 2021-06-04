import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sevgram/data/providers/token_provider.dart';
import 'package:sevgram/ui/home/home_screen.dart';
import 'package:sevgram/ui/login/login_screen.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/tools.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () async {
      String token = await context.read<TokenProvider>().loadToken();
      if (token != null) {
        Tools.navigateReplace(context, HomeScreen());
      } else {
        Tools.navigateReplace(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.initialScreenSize(context);

    return Scaffold(
      backgroundColor: Themes.primary,
    );
  }
}
