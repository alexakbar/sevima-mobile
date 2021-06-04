import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:sevgram/components/buttons/primary_button.dart';
import 'package:sevgram/components/commons/flat_card.dart';
import 'package:sevgram/components/dialog/custom_alert_dialog.dart';
import 'package:sevgram/components/textareas/password_textarea.dart';
import 'package:sevgram/components/textareas/textarea.dart';
import 'package:sevgram/data/providers/token_provider.dart';
import 'package:sevgram/data/providers/user_provider.dart';
import 'package:sevgram/data/services/api_interface.dart';
import 'package:sevgram/data/services/entities/login_response.dart';
import 'package:sevgram/ui/home/home_screen.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/tools.dart';
import 'package:sevgram/utils/widget_helper.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool enableButton = false;
  ApiInterface apiInterface;

  void doRegister() {
    var body = Map();
    body["email"] = emailController.text;
    body["username"] = usernameController.text;
    body["fullname"] = fullnameController.text;
    body["password"] = passwordController.text;
    body["phone"] = phoneController.text;

    apiInterface.doRegister(
      body: body,
      onFinish: (response) {
        if (response.statusCode == 200) {
          LoginResponse loginResponse =
              LoginResponse.fromJson(jsonDecode(response.body));

          if (loginResponse.error) {
            Navigator.pop(context);
            Tools.showCustomDialog(
              context,
              child: CustomAlertDialog(
                title: "Error",
                message: loginResponse.message,
                buttonText: "Dismiss",
                onConfirm: () {
                  Navigator.pop(context);
                },
              ),
            );
          } else {
            context.read<TokenProvider>().saveToken(loginResponse.token);
            context.read<UserProvider>().loadNetworkUser(context, onFinish: () {
              Navigator.pop(context);
              Tools.navigateRefresh(context, HomeScreen(), "/home");
            });
          }
        } else {
          LoginResponse loginResponse =
              LoginResponse.fromJson(jsonDecode(response.body));

          Navigator.pop(context);
          Tools.showCustomDialog(
            context,
            child: CustomAlertDialog(
              title: "Error",
              message: loginResponse.message,
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
      enableButton = emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          fullnameController.text.isNotEmpty &&
          usernameController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      apiInterface = ApiInterface(context);
    });

    emailController.addListener(onTextChange);
    passwordController.addListener(onTextChange);

    Tools.changeStatusbarIconColor(
      darkIcon: true,
      statusBarColor: Themes.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.hp(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatCard(
                    borderRadius: BorderRadius.circular(32.w()),
                    width: 36.w(),
                    height: 36.w(),
                    color: Themes.greyBg,
                    child: Center(
                      child: Text(
                        "S",
                        style: Themes().primaryBold22,
                      ),
                    ),
                  ),
                ],
              ).addSymmetricMargin(
                vertical: 18.h(),
              ),
              Text(
                "Sign Up",
                style: Themes().primaryBold22.withSize(36),
              ).addMarginTop(12.h()),
              Text(
                "Sign Up to create an account",
                style: Themes().gray14,
              ),
              TextArea(
                controller: fullnameController,
                hint: "input fullname",
              ).addMarginTop(56.h()),
              TextArea(
                controller: usernameController,
                hint: "input username",
              ).addMarginTop(14.h()),
              TextArea(
                controller: emailController,
                hint: "input email",
              ).addMarginTop(14.h()),
              TextArea(
                controller: phoneController,
                hint: "input phone",
              ).addMarginTop(14.h()),
              PasswordTextarea(
                controller: passwordController,
                hint: "input password",
              ).addMarginTop(14.h()),
              PrimaryButton(
                enable: enableButton,
                onTap: () {
                  Tools.showProgressDialog(context);
                  doRegister();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sign Up",
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
