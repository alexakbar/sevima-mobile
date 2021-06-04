import 'package:sevgram/components/buttons/primary_button.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  CustomAlertDialog({
    Key key,
    this.title,
    this.message,
    this.onConfirm,
    this.buttonText = "OK",
  }) : super(key: key);

  final String title;
  final String message;
  final VoidCallback onConfirm;
  final String buttonText;

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
          padding: EdgeInsets.all(24.w()),
          width: 80.wp(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title, style: Themes().blackBold16),
              Container(
                margin: EdgeInsets.only(top: 4.h()),
                child: Text(
                  message,
                  style: Themes().black14.apply(color: Themes.grey),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24.h()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    PrimaryButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w(),
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
