import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color rippleColor;
  final Color color;
  final Color textColor;
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final Color borderColor;
  final bool enable;
  final bool elevateButtonOnTap;
  final bool lightButton;

  PrimaryButton({
    Key key,
    this.text,
    this.onTap,
    this.color,
    this.rippleColor,
    this.textColor,
    this.child,
    this.padding,
    this.borderColor,
    this.radius = 4,
    this.enable = true,
    this.elevateButtonOnTap = true,
    this.lightButton,
  }) : super(key: key);

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  Color borderColor;
  Color rippleColor;
  Color color;
  Color textColor;
  EdgeInsets padding;
  bool lightButton;

  bool isLight() {
    return (color.red * 0.299 + color.green * 0.587 + color.blue * 0.114) > 186;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.color == null) {
      color = Themes.primary;
    } else {
      color = widget.color;
    }

    if (widget.lightButton == null) {
      lightButton = isLight();
    } else {
      lightButton = widget.lightButton;
    }

    if (widget.rippleColor == null) {
      rippleColor = lightButton
          ? Colors.black.withOpacity(0.3)
          : Colors.white.withOpacity(0.3);
    } else {
      rippleColor = widget.rippleColor;
    }

    if (widget.textColor == null) {
      textColor = Colors.white;
    } else {
      textColor = widget.textColor;
    }

    if (widget.borderColor == null) {
      borderColor = Colors.transparent;
    } else {
      borderColor = widget.borderColor;
    }

    if (widget.padding == null) {
      padding = EdgeInsets.all(16.w());
    } else {
      padding = widget.padding;
    }

    return RaisedButton(
      padding: EdgeInsets.zero,
      highlightElevation: widget.elevateButtonOnTap ? null : 0,
      highlightColor: rippleColor.withOpacity(0.1),
      splashColor: rippleColor,
      color: color,
      disabledColor: Themes.primaryDisableButton,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.radius.w()),
        side: BorderSide(
          color: borderColor,
        ),
      ),
      onPressed: widget.enable ? widget.onTap : null,
      child: Padding(
        padding: padding,
        child: widget.child != null
            ? widget.child
            : Center(
                child: Text(
                  widget.text,
                  style: GoogleFonts.overpass(
                    textStyle: TextStyle(
                      fontSize: 14.f(),
                      color: (widget.onTap != null && widget.enable)
                          ? textColor
                          : Themes.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
