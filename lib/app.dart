import 'package:enciclopiedia_deportiva/common/constants/colors.dart';
import 'package:enciclopiedia_deportiva/common/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home.dart';

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final page = Home();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme("en"),
      themeMode: ThemeMode.light,
      home: new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: page,
        backgroundColor: darkBG,
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
