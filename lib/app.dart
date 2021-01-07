import 'package:enciclopiedia_deportiva/common/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:splashscreen/splashscreen.dart';

import 'common/constants/general.dart';
import 'home.dart';

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final page = Home();
    if (isIos) {
      return CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: buildLightCupertinoTheme(context),
        localizationsDelegates: [
          DefaultCupertinoLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate
        ],
        home: new SplashScreen(
          seconds: 3,
          navigateAfterSeconds: page,
          backgroundColor: Color(0xFF000000),
          image: Image.asset(
            "assets/images/ic_logo.png",
            scale: 0.8,
            fit: BoxFit.fitWidth,
          ),
          loaderColor: Color(0xffCDAE62),
          loadingText: new Text(
            "Welcome",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
        ),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme("en"),
      themeMode: ThemeMode.light,
      home: new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: page,
        backgroundColor: Color(0xFF000000),
        image: Image.asset(
          "assets/images/ic_logo.png",
          scale: 0.8,
          fit: BoxFit.fitWidth,
        ),
        loaderColor: Color(0xffCDAE62),
        loadingText: new Text(
          "Welcome",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
      ),
    );
  }
}
