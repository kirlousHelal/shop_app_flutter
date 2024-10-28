import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme() => ThemeData(
      // useMaterial3: false,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: defaultColor as MaterialColor,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedItemColor: Colors.grey,
        elevation: 15,
        selectedItemColor: defaultColor,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),

      appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 1,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black,
          )),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.maxFinite),
          backgroundColor: defaultColor,
          textStyle: const TextStyle(fontSize: 20),
          foregroundColor: Colors.white,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.5, // Adjust the width as needed
          ),
        ),
      ),
    );

ThemeData darkTheme() => ThemeData(
      // useMaterial3: false,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: defaultColor as MaterialColor,
        brightness: Brightness.dark,
        cardColor: const Color(0xff121212),
      ).copyWith(
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        surface: const Color(0xff121212),
      ),
      // colorScheme: ColorScheme.dark(
      //   primary: defaultColor as Color,
      // ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedItemColor: Colors.grey,
        elevation: 15,
        selectedItemColor: defaultColor,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),

      appBarTheme: const AppBarTheme(
          // color: Colors.white,
          elevation: 1,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            // color: Colors.black,
          )),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.maxFinite),
          backgroundColor: defaultColor,
          textStyle: const TextStyle(fontSize: 20),
          foregroundColor: Colors.white,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.5, // Adjust the width as needed
          ),
        ),
      ),
    );
