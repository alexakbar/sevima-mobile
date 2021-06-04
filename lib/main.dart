import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sevgram/data/providers/post_provider.dart';
import 'package:sevgram/data/providers/token_provider.dart';
import 'package:sevgram/data/providers/user_provider.dart';
import 'package:sevgram/ui/home/home_screen.dart';
import 'package:sevgram/ui/login/login_screen.dart';
import 'package:sevgram/ui/spashscreen/spash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider(create: (_) => TokenProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SevGram',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home' : (context) => HomeScreen(),
       },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        }),
      ),
      home: SplashScreen(),
    );
  }
}
