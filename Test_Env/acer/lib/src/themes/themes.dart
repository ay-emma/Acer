import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: ddarkGreen,
  cardColor: dblack,
  canvasColor: accentGreen, //4
  primaryColorDark: lightGreen, //3
  scaffoldBackgroundColor: ddarkGreen, //1
  accentColor: accentDark, //2
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.green,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: white,
    unselectedLabelColor: white,
    labelStyle: GoogleFonts.nunito(
        color: white,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15),
  ),

  textTheme: TextTheme(
    headline1: GoogleFonts.nunito(
        fontSize: 103, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.nunito(
        fontSize: 64, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.nunito(fontSize: 51, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.nunito(
        fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.nunito(fontSize: 26, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.nunito(
        fontSize: 21,
        color: whiteGreen,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15),
    subtitle1: GoogleFonts.nunito(
        color: accentGreen,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15),
    subtitle2: GoogleFonts.nunito(
        color: accentGreen,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1),
    bodyText1: GoogleFonts.nunito(
        fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.nunito(
      color: accentGreen,
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    button: GoogleFonts.nunito(
        fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.nunito(
      fontSize: 13,
      color: white,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    overline: GoogleFonts.nunito(
      fontSize: 11,
      color: accentGreen,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.2,
    ),
  ),
);

ThemeData lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: lightGreen,
  canvasColor: darkGreen, //4
  cardColor: lightGreen, //5
  backgroundColor: lightGreen,
  primaryColorDark: ddarkGreen, //3
  //accentColor: accentGreen,
  accentColor: white, //2
  scaffoldBackgroundColor: whiteGreen, //1

  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.green,
  ),

  // TextThemes
  tabBarTheme: TabBarTheme(
    labelColor: dblack,
    unselectedLabelColor: ddarkGreen,
    labelStyle: GoogleFonts.nunito(
        color: dblack,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15),
  ),

  textTheme: TextTheme(
    headline1: GoogleFonts.nunito(
      fontSize: 103,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: lightGreen,
    ),
    headline2: GoogleFonts.nunito(
      fontSize: 64,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: lightGreen,
    ),
    headline3: GoogleFonts.nunito(
      fontSize: 51,
      fontWeight: FontWeight.w400,
      color: lightGreen,
    ),
    headline4: GoogleFonts.nunito(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headline5: GoogleFonts.nunito(
      fontSize: 26,
      fontWeight: FontWeight.w400,
      color: lightGreen,
    ),
    headline6: GoogleFonts.nunito(
        color: ddarkGreen,
        fontSize: 21,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15),
    subtitle1: GoogleFonts.nunito(
        color: dblack,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15),
    subtitle2: GoogleFonts.nunito(
        color: dblack,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1),
    bodyText1: GoogleFonts.nunito(
        color: dblack,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5),
    bodyText2: GoogleFonts.nunito(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: dblack),
    button: GoogleFonts.nunito(
        color: dblack,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25),
    caption: GoogleFonts.nunito(
        color: dblack,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4),
    overline: GoogleFonts.nunito(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: dblack,
        letterSpacing: 1.2),
  ),
);
