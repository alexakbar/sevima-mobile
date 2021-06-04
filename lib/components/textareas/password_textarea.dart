import 'package:sevgram/components/buttons/ripple_button.dart';
import 'package:sevgram/components/textareas/textarea.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/widget_helper.dart';
import 'package:flutter/material.dart';

class PasswordTextarea extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool visibilitButton;

  PasswordTextarea({
    Key key,
    this.hint,
    this.controller,
    this.visibilitButton = true,
  }) : super(key: key);

  @override
  _PasswordTextareaState createState() => _PasswordTextareaState();
}

class _PasswordTextareaState extends State<PasswordTextarea> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return TextArea(
      controller: widget.controller,
      secureInput: !visible,
      hint: widget.hint,
      endIcon: widget.visibilitButton
          ? RippleButton(
              padding: EdgeInsets.all(8.w()),
              radius: 32,
              lightButton: true,
              color: Colors.transparent,
              onTap: () {
                setState(() {
                  visible = !visible;
                });
              },
              child: Icon(
                visible
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                size: 20.f(),
                color: Themes.primary,
              ),
            ).addMarginRight(4.w())
          : null,
    );
  }
}
