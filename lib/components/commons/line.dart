import 'package:flutter/material.dart';
import 'package:sevgram/utils/themes.dart';

class Line extends StatelessWidget {
  final Color color;
  final double width;
  final double height;

  const Line({
    Key key,
    this.color = Themes.stroke,
    this.width = double.infinity,
    this.height = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }
}
