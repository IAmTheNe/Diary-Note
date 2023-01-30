import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///A class that contains all the styles used in the app
class AppStyle {
  /// Creating a dark theme for the app.
  static final dark = ThemeData(
    platform: TargetPlatform.iOS,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 3.0,
          color: Colors.orange,
        ),
      ),
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Colors.orange,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 40),
        backgroundColor: CustomColor.lavender.value,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    ),
    useMaterial3: true,
  );
}

enum CustomColor {
  white(Colors.white),
  smoky(Color(0xFF1C1D2C)),
  grey(Colors.grey),
  lavender(Color(0xFF706FC8)),
  lightGrey(Color(0xFF7A7989));

  final Color _value;
  const CustomColor(this._value);

  Color get value => _value;
}
