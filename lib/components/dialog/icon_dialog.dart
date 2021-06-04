import 'package:sevgram/components/buttons/primary_button.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/widget_helper.dart';
import 'package:flutter/material.dart';

class IconDialog extends StatelessWidget {
  IconDialog({
    Key key,
    this.title,
    this.message,
    this.onConfirm,
    this.buttonText = "OK",
    @required this.icon,
  }) : super(key: key);

  final String title;
  final String message;
  final VoidCallback onConfirm;
  final String buttonText;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.w()),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w(),
            vertical: 40.h(),
          ),
          width: 70.wp(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              icon,
              Text(
                title,
                textAlign: TextAlign.center,
                style: Themes().blackBold16,
              ).addMarginTop(16.h()),
              Container(
                margin: EdgeInsets.only(top: 4.h()),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Themes().black14.apply(color: Themes.grey),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24.h()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    PrimaryButton(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h(),
                      ),
                      text: buttonText,
                      onTap: onConfirm,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
