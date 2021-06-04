import 'package:sevgram/components/buttons/ripple_button.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/widget_helper.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onTapBack;
  final double height;
  final Widget action;
  final String title;
  final Color color;
  final bool showDivider;

  DefaultAppBar({
    Key key,
    this.onTapBack,
    this.height,
    this.action,
    this.title,
    this.color = Colors.white,
    this.showDivider = true,
  }) : super(key: key);

  @override
  _DefaultAppBarState createState() => _DefaultAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, height);
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Themes.white,
          height: 20.h(),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w(),
            vertical: 6.w(),
          ),
          color: Themes.white,
          width: double.infinity,
          height: widget.height - 20.h(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RippleButton(
                    radius: 32.w(),
                    padding: EdgeInsets.all(8.w()),
                    lightButton: true,
                    color: Themes.white,
                    onTap: () {
                      if (widget.onTapBack != null) {
                        widget.onTapBack();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Icon(Icons.chevron_left_rounded),
                  ),
                  Text(
                    widget.title,
                    style: Themes().blackBold14,
                  ).addMarginLeft(16.w()),
                ],
              ),
              if (widget.action != null) widget.action
            ],
          ),
        ),
        if (widget.showDivider)
          Container(
            width: double.infinity,
            height: 1,
            color: Themes.stroke.withOpacity(0.5),
          )
      ],
    );
  }
}
