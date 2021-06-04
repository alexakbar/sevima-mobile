import 'package:flutter/widgets.dart';

extension ResponsiveInt on int {
  dynamic w() => Responsive.w(this.toDouble());
  dynamic h() => Responsive.h(this.toDouble());
  dynamic f() => Responsive.f(this.toDouble());
  dynamic wp() => Responsive.wp(this.toDouble());
  dynamic hp() => Responsive.hp(this.toDouble());
}

extension ResponsiveDouble on double {
  dynamic w() => Responsive.w(this.toDouble());
  dynamic h() => Responsive.h(this.toDouble());
  dynamic f() => Responsive.f(this.toDouble());
  dynamic wp() => Responsive.wp(this.toDouble());
  dynamic hp() => Responsive.hp(this.toDouble());
}

class Responsive {
  static double _originScreenWidth = 411.42857142857144;
  static double _originScreenHeight = 569.1428571428571;
  static double _screenWidth;
  static double _screenHeight;
  static double _blockSize;
  static double _blockSizeVertical;
  static double _textScaleFactor;
  BuildContext context;

  static void initialScreenSize(BuildContext context) {
    if (MediaQuery.of(context).size.height /
            MediaQuery.of(context).size.width >=
        1.77777778) {
      _originScreenWidth = 360.0;
      _originScreenHeight = 640.0;
    }
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _blockSize = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;
    _textScaleFactor = _screenWidth / _originScreenWidth;
  }

  static double h(double height) {
    var calculation = (height / _originScreenHeight) * 100;
    return calculation * _blockSizeVertical;
  }

  static double w(double width) {
    var calculation = (width / _originScreenWidth) * 100;
    return calculation * _blockSize;
  }

  static double wp(double width) {
    return _screenWidth * (width / 100.0);
  }

  static double hp(double height) {
    return _screenHeight * (height / 100.0);
  }

  static double f(double size) {
    return size * _textScaleFactor;
  }
}
