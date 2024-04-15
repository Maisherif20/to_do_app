import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
const Color lightPrimaryColor=Color.fromRGBO(93, 156, 236, 1);
const Color lightScaffoldColor = Color.fromRGBO(223, 236, 219, 1);
const Color darkScaffoldColor = Color(0XFF060E1E);
const Color greenColor = Color.fromRGBO(97, 231, 87, 1);
const Color redColor=Color.fromRGBO(236, 75, 75, 1);
const Color darkPrimaryColor = Color.fromRGBO(93, 156, 236, 1);
const Color greyColor = Color.fromRGBO(200, 201, 203, 1);

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryColor: lightPrimaryColor,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white , fontSize: 30 , fontStyle: GoogleFonts.poppins().fontStyle ),
      backgroundColor: lightPrimaryColor,
    ),
    scaffoldBackgroundColor: lightScaffoldColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedItemColor: lightPrimaryColor,
      unselectedItemColor: greyColor,
    ),
    bottomAppBarTheme:BottomAppBarTheme(color: Colors.white),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: darkPrimaryColor,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white , fontSize: 30 , fontStyle: GoogleFonts.poppins().fontStyle ),
      backgroundColor: darkPrimaryColor,
    ),
    scaffoldBackgroundColor: darkScaffoldColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedItemColor: darkPrimaryColor,
      unselectedItemColor: greyColor,
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.black,),
  );

}
