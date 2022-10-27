import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFD9E80);
const Color secondaryColor = Color(0xFFDDE4EB);

const Color bgColor = Color(0xFFFAFAFA);
const Color bgSelected = Color(0xFFC29AFF);
const Color activeMenuColor = Color(0xFF484F5D);
const Color borderColor = Color(0xFFDDE4EB);
const Color borderBlueColor = Color(0xFF8DA1CE);
const Color colorWhite = Color(0xFFFFFFFF);
const Color colorBlack = Color(0xFF16162F);
const Color colorGrey = Color(0xFFF6F6F6);
const Color colorGrey2 = Color(0xFFBFC2C7);
const Color colorGrey3 = Color(0xFF8A919C);
const Color colorGreyBlue = Color(0xFFA3AEC1);
const Color colorGreyDark = Color(0xFFABA6AC);
const Color colorBlue = Color(0xFF70A0FF);
const Color colorBlueDeep = Color(0xFF4D0EFF);
const Color colorYellow = Color(0xFFFEC842);
const Color colorRed = Color(0xFFFF6868);
const Color colorGreen = Color(0xFF06D186);

const Color linearStart1 = Color(0xFF203253);
const Color linearEnd1 = Color(0xFF182640);

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  textTheme: myTextTheme,
  dividerColor: borderColor,
  appBarTheme: const AppBarTheme(
    elevation: 0,
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: primaryColor,
    secondary: secondaryColor,
    onSecondary: secondaryColor,
    error: colorRed,
    onError: colorRed,
    background: bgColor,
    onBackground: bgColor,
    surface: colorGreyBlue,
    onSurface: colorGreyBlue,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: secondaryColor,
    unselectedItemColor: Colors.grey,
  ),
);

final myTextTheme = TextTheme(
  headline1: GoogleFonts.roboto(fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.roboto(fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.roboto(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.roboto(fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.roboto(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.roboto(fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
