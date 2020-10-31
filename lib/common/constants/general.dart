import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

/// check if the environment is web
final bool isWeb = UniversalPlatform.isWeb;
final bool isIos = UniversalPlatform.isIOS;
final bool isAndroid = UniversalPlatform.isAndroid;
final bool isMacOS = UniversalPlatform.isMacOS;
final bool isWindow = UniversalPlatform.isWindows;
final bool isFuchsia = UniversalPlatform.isFuchsia;

final Image surf = Image.asset('assets/images/surf.png');
final Image baseball = Image.asset('assets/images/baseball.png');
