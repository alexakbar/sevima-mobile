import 'package:flutter/material.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  BuildContext context;
  static const Color black = Color(0xff2A2A2A);
  static const Color primary = Color(0xff254e6c);
  static const Color darkPrimary = Color(0xff131C3E);
  static const Color secondary = Color(0xffF78627);
  static const Color darkSecondary = Color(0xffE31745);
  static const Color primaryDisableButton = Color(0xffC2C2C2);
  static const Color blue = Color(0xff4751D7);
  static const Color reddish = Color(0xffFF576B);
  static const Color cyan = Color(0xff00D4E0);
  static const Color orange = Color(0xffFFFF904A);
  static const Color purple = Color(0xff874EDC);
  static const Color blueGrey = Color(0xffA9C8F2);
  static const Color magenta = Color(0xffE92B96);

  static const Color red = Color(0xffEC4067);
  static const Color yellow = Color(0xffFFD228);
  static const Color grey = Color(0xff757575);
  static const Color green = Color(0xff03CEA4);
  static const Color greyBg = Color(0xffECEBE8);
  static const Color stroke = Color(0xffDEDEDE);
  static const Color line = Color(0xffF2F2F2);
  static const Color white = Color(0xffffffff);
  static const Color transparent = Color(0x00ffffff);
  static BoxShadow topSoftShadow = BoxShadow(
    offset: Offset(0, -4),
    spreadRadius: 2,
    blurRadius: 24,
    color: Colors.black.withOpacity(0.05),
  );
  static BoxShadow softShadow = BoxShadow(
    offset: Offset(0, 4),
    spreadRadius: 2,
    blurRadius: 24,
    color: Colors.black.withOpacity(0.05),
  );

  static MaterialColor primaryMaterialColor = MaterialColor(
    0xff202F67,
    const <int, Color>{
      50: const Color(0xff202F67),
      100: const Color(0xff202F67),
      200: const Color(0xff202F67),
      300: const Color(0xff202F67),
      400: const Color(0xff202F67),
      500: const Color(0xff202F67),
      600: const Color(0xff202F67),
      700: const Color(0xff202F67),
      800: const Color(0xff202F67),
      900: const Color(0xff202F67),
    },
  );

  TextStyle whiteBold32;
  TextStyle whiteBold28;
  TextStyle whiteBold26;
  TextStyle whiteBold22;
  TextStyle whiteOpacity14;
  TextStyle whiteOpacity12;
  TextStyle white16;
  TextStyle white14;
  TextStyle white12;
  TextStyle white10;
  TextStyle whiteBold18;
  TextStyle whiteBold16;
  TextStyle whiteBold14;
  TextStyle whiteBold12;
  TextStyle blackBold20;
  TextStyle black16;
  TextStyle blackOpacity12;
  TextStyle black70Opacity12;
  TextStyle blackBold16;
  TextStyle blackBold18;
  TextStyle secondary14;
  TextStyle secondary18;
  TextStyle secondaryBold18;
  TextStyle secondaryBold14;
  TextStyle blackBold12;
  TextStyle blackBold14;
  TextStyle grayLetterSpacing12;
  TextStyle grayBoldLetterSpacing12;
  TextStyle gray10;
  TextStyle gray12;
  TextStyle grayNoHeight12;
  TextStyle gray14;
  TextStyle black12;
  TextStyle black14;
  TextStyle blackOpacity14;
  TextStyle appbarTitle;
  TextStyle primaryBold22;
  TextStyle primaryBold18;
  TextStyle primaryBold14;
  TextStyle primaryBold12;
  TextStyle primary12;

  TextStyle textStyle({
    double size = 14,
    Color color,
    FontWeight fontWeight,
    double height,
  }) {
    return GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: height / size,
        fontSize: size.f(),
        color: color != null ? color : Themes.black,
        fontWeight: fontWeight,
      ),
    );
  }

  Themes({bool withLineHeight = false}) {
    primary12 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 12.f(),
        color: Themes.primary,
      ),
    );

    primaryBold12 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 12.f(),
        color: Themes.primary,
        fontWeight: FontWeight.bold,
      ),
    );

    primaryBold14 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 14.f(),
        color: Themes.primary,
        fontWeight: FontWeight.bold,
      ),
    );

    primaryBold22 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 22.f(),
        color: Themes.primary,
        fontWeight: FontWeight.bold,
      ),
    );

    primaryBold18 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 18.f(),
        color: Themes.primary,
        fontWeight: FontWeight.bold,
      ),
    );

    appbarTitle = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        fontSize: 26.f(),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    blackBold20 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 20.f(),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    black16 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 16.f(),
        color: Themes.black,
      ),
    );

    secondary14 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 14.f(),
        color: Themes.secondary,
      ),
    );

    secondary18 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 18.f(),
        color: Themes.secondary,
      ),
    );

    secondaryBold14 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 14.f(),
        color: Themes.secondary,
        fontWeight: FontWeight.bold,
      ),
    );

    secondaryBold18 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 18.f(),
        color: Themes.secondary,
        fontWeight: FontWeight.bold,
      ),
    );

    blackBold18 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 18.f(),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    black70Opacity12 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 12.f(),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    blackOpacity12 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 12.f(),
        color: Themes.black.withOpacity(0.6),
      ),
    );

    blackBold16 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 16.f(),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    blackOpacity14 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 14.f(),
        color: Themes.black.withOpacity(0.6),
      ),
    );

    blackBold12 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 12.f(),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    blackBold14 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 14.f(),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    grayLetterSpacing12 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        fontSize: 12.f(),
        color: Color(0xff757575),
        letterSpacing: 2.0,
      ),
    );

    grayBoldLetterSpacing12 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        fontSize: 12.f(),
        color: Color(0xff757575),
        letterSpacing: 2.0,
        fontWeight: FontWeight.bold,
      ),
    );

    gray12 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 12.f(),
        color: Themes.grey,
      ),
    );

    gray10 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 10.f(),
        color: Themes.grey,
      ),
    );

    grayNoHeight12 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        fontSize: 12.f(),
        color: Themes.grey,
      ),
    );

    black12 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 12.f(),
        color: Themes.black,
      ),
    );

    white16 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 16.f(),
        color: Colors.white,
      ),
    );

    white14 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 14.f(),
        color: Colors.white,
      ),
    );

    white12 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 12.f(),
        color: Colors.white,
      ),
    );

    white10 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.2 : null,
        fontSize: 10.f(),
        color: Colors.white,
      ),
    );

    gray14 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 14.f(),
        color: Themes.grey,
      ),
    );

    black14 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 14.f(),
        color: Themes.black,
      ),
    );

    whiteBold18 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 18.f(),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    whiteBold16 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 16.f(),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    whiteBold12 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 12.f(),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    whiteBold14 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 14.f(),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    whiteOpacity14 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 14.f(),
        color: Colors.white,
      ),
    );

    whiteOpacity12 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 12.f(),
        color: Colors.white,
      ),
    );

    whiteBold32 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        fontSize: 32.f(),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    whiteBold28 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        fontSize: 28.f(),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    whiteBold26 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        fontSize: 26.f(),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    whiteBold22 = GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : 1.2,
        fontSize: 22.f(),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

extension addDecoration on TextStyle {
  TextStyle withUnderline() {
    return this.copyWith(
      decoration: TextDecoration.underline,
      shadows: [
        Shadow(color: Colors.black, offset: Offset(0, -3)),
      ],
      color: Colors.transparent,
      decorationThickness: 4,
      decorationColor: Colors.black,
    );
  }

  TextStyle boldText() {
    return this.copyWith(
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle withColor(Color color) {
    return this.copyWith(
      color: color,
    );
  }

  TextStyle withSize(double size) {
    return this.copyWith(
      fontSize: size,
    );
  }

  TextStyle withHeight(double height) {
    return this.copyWith(
      height: height,
    );
  }
}
