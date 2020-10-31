import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Google fonts constant setting: https://fonts.google.com/
TextTheme eTextTheme(theme, String language) {
  switch (language) {
    case 'en':
      return GoogleFonts.openSansTextTheme(theme);
    default:
      return GoogleFonts.ralewayTextTheme(theme);
  }
}

TextTheme eHeadlineTheme(theme, [language = 'en']) {
  switch (language) {
    case 'en':
      return GoogleFonts.openSansCondensedTextTheme(theme);
    default:
      return GoogleFonts.ralewayTextTheme(theme);
  }
}
