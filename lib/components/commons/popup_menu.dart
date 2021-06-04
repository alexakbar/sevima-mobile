import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:flutter/material.dart';

class MenuItem {
  String text;
  dynamic value;
  Color color;

  MenuItem({
    this.text,
    this.value,
    this.color,
  });
}

class PopupMenu extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function(String value) onSelected;
  final List<MenuItem> menus;
  final EdgeInsets padding;
  final double iconSize;

  PopupMenu({
    Key key,
    this.icon,
    this.color,
    this.onSelected,
    this.menus,
    this.padding,
    this.iconSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.w())),
        side: BorderSide(
          color: Themes.stroke,
        ),
      ),
      child: Container(
        padding: padding != null ? padding : EdgeInsets.all(0.w()),
        child: Icon(
          icon,
          size: iconSize.f(),
          color: color,
        ),
      ),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return menus
            .map(
              (e) => PopupMenuItem<String>(
                value: e.value,
                child: Text(
                  e.text,
                  style: Themes(withLineHeight: false).black14.apply(
                        color: e.color != null ? e.color : Themes.black,
                      ),
                ),
              ),
            )
            .toList();
      },
    );
  }
}
