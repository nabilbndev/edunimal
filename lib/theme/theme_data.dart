import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color brandColor = const Color(0xFFFFC01D);
TextStyle edunimalFont = GoogleFonts.comfortaa();

TextTheme edunimalTextTheme = const TextTheme(
    titleLarge: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
    displayLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.w700, color: Colors.black),
    displayMedium: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
    bodyLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
    bodyMedium: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
    bodySmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400));
