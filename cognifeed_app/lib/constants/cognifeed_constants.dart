import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CognifeedColors {
  static Color dockEggBlue = Color(0xffe9fdfc);
  static Color aquaMarine = Color(0xff00c9c3);
  static Color teal = Color(0xff00928d);
  static Color duskyBlue = Color(0xff445ba0);
}

class CognifeedTheme {
  static ThemeData getTheme() {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        helperStyle: TextStyle(color: Colors.teal),
        contentPadding: EdgeInsets.only(left: 25, top: 0, bottom: 0, right: 0),
        labelStyle: CognifeedTypography.textStyle2,
        hintStyle: TextStyle(
          color: CognifeedColors.teal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: CognifeedColors.aquaMarine,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.0),
          borderSide: BorderSide(
            width: 1.2,
            color: CognifeedColors.aquaMarine,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.0),
          borderSide: BorderSide(
            width: 1.2,
            color: CognifeedColors.aquaMarine,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            width: 2,
            color: CognifeedColors.aquaMarine,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            width: 2,
            color: CognifeedColors.aquaMarine,
          ),
        ),
      ),
    );
  }
}

class CognifeedTypography {
  static TextStyle textStyle2 = TextStyle(
    fontSize: 17,
    fontFamily: "SegoeUI",
    fontWeight: FontWeight.bold,
    color: CognifeedColors.aquaMarine,
  );
  static TextStyle textStyle4 = TextStyle(
    fontSize: 14,
    fontFamily: "SegoeUI",
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
  static TextStyle textStyleOnboardHeading = TextStyle(
    fontSize: 24,
    fontFamily: "PoorRichard",
    fontWeight: FontWeight.normal,
    color: Color(0xff192965),
  );
  static TextStyle searchBox = TextStyle(
    fontSize: 24,
    fontFamily: "CaroniR",
    fontWeight: FontWeight.normal,
    color: Color(0xff192965),
  );
  static TextStyle tags = TextStyle(
    fontSize: 15,
    fontFamily: "Jet",
    fontWeight: FontWeight.normal,
    color: Color(0xff192965),
  );
  static TextStyle title = TextStyle(
    fontSize: 17,
    fontFamily: "Kicker",
    letterSpacing: 1,
    wordSpacing: 1.3,
    height: 1.4,
    fontWeight: FontWeight.w600,
    color: Color(0xff192965),
  );
}

final String baseUrl = "http://192.168.0.98:3100/api";

class Cognifeed {
  static SharedPreferences pref;
}
