import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const BodyTextSize = 16.0;

const String FontNameDefault = 'PoiterOne';
const String FontNameTitle = 'Montserrat';

Color kPrimaryColor = const Color(0xFF28292E);
//Color kPrimaryColor = Color(0xFFEC407A);
Color kSecondaryColor = const Color(0xFFEF9A9A);
// Color kSecondaryColor = Color(0xFFD6D6D6);
Color kBackgroundColor = const Color(0xFF28292E);

//Color kAccentColor = Color(0xFF8FECFF);
Color kAccentColor = Colors.red;

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      background: Colors.grey[200],
      secondary: Colors.grey[350],
      onSecondary: Colors.grey[600]),
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: Color(0xFFBBDEFB),
  hintColor:Color(0xFFDCDCDE),
  textTheme: const TextTheme(
    displayMedium: TextStyle(color: Colors.black87),
    titleLarge: TextStyle(
      fontFamily: FontNameTitle,
      fontSize: MediumTextSize,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontFamily: FontNameDefault,
      fontSize: BodyTextSize,
      color: Colors.black,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: HexColor('#46C0D3')),
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.grey)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(color: HexColor("#d8d4da"))),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.red, width: 2.0)),
  ),
  appBarTheme: AppBarTheme(
    color: HexColor("#f0ecf3"),
  ),
  bottomNavigationBarTheme:
      BottomNavigationBarThemeData(selectedItemColor: HexColor("#46C0D3")),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: HexColor("#46C0D3"),
    foregroundColor: Colors.white,
  ),
  cardColor: HexColor("#1C1B1F"),
  scaffoldBackgroundColor: HexColor("#f0ecf3"),
  primaryColorLight: HexColor("#00093C"),
  canvasColor: HexColor('#FFFBFE'),
  dividerColor: HexColor("#E4E4E5"),
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      background: Colors.grey[900],
      seedColor: Colors.black,
      secondary: Colors.grey[700],
      onSecondary: Colors.grey[100]),
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: HexColor("#4A4657"),
  hintColor: HexColor("#645E62"),
  textTheme: const TextTheme(
    displayMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(
      fontFamily: FontNameTitle,
      fontSize: MediumTextSize,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontFamily: FontNameDefault,
      fontSize: BodyTextSize,
      color: Colors.white,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: HexColor("#323135"),
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.grey)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(color: HexColor("#464549"))),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.red, width: 2.0)),
  ),
  appBarTheme: AppBarTheme(
    color: HexColor("#1C1B1F"),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('#323135'),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: HexColor("#4F378B"),
    foregroundColor: HexColor("#EADDFF"),
  ),
  cardColor: HexColor("#1C1B1F"),
  scaffoldBackgroundColor: HexColor("#1C1B1F"),
  primaryColorLight: HexColor("#d8d4da"),
  canvasColor: HexColor("#323135"),
  dividerColor: HexColor("#636363"),
);
