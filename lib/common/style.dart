import 'package:enciclopiedia_deportiva/common/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'config/fonts.dart';

const ColorScheme colorScheme = ColorScheme(
  primary: primaryColor,
  primaryVariant: primaryVariantColor,
  secondary: secondaryColor,
  secondaryVariant: secondaryVariantColor,
  surface: surfaceWhite,
  background: backgroundWhite,
  error: errorRed,
  onPrimary: darkBG,
  onSecondary: grey900,
  onSurface: grey900,
  onBackground: grey900,
  onError: surfaceWhite,
  brightness: Brightness.light,
);

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: grey900);
}

ThemeData buildLightTheme(String language) {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: colorScheme,
    cardColor: Colors.white,
    textSelectionColor: Colors.white,
    errorColor: errorRed,
    buttonTheme: const ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.normal,
        buttonColor: darkBG),
    primaryColorLight: lightBG,
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildTextTheme(base.textTheme, language),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme, language),
    accentTextTheme: _buildTextTheme(base.accentTextTheme, language),
    iconTheme: _customIconTheme(base.iconTheme),
    hintColor: Colors.black26,
    backgroundColor: Colors.white,
    primaryColor: kLightPrimary,
    accentColor: kLightAccent,
    cursorColor: kLightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      iconTheme: IconThemeData(
        color: kLightAccent,
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );
}

TextTheme _buildTextTheme(TextTheme base, String language) {
  return eTextTheme(base, language)
      .copyWith(
        headline5: base.headline5
            .copyWith(fontWeight: FontWeight.w600, color: Colors.red),
        headline6: base.headline6.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
        ),
        subtitle1: base.subtitle1.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
        button: base.button.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      )
      .apply(
        displayColor: grey900,
        bodyColor: grey900,
      )
      .copyWith(headline4: eHeadlineTheme(base).headline4.copyWith());
}

CupertinoThemeData buildLightCupertinoTheme(BuildContext context) {
  CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
  return cupertinoTheme.copyWith(
    barBackgroundColor: Color(0xFF000000),
    primaryColor: darkBG,
  );
}
