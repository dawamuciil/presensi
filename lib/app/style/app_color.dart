import 'package:flutter/cupertino.dart';

class AppColor {
  static LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF16A085)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Color primary = Color(0xFF4B8673);
  static Color card = Color(0xFF4B8673);
  static Color buttontext = Color.fromARGB(255, 28, 62, 188);
  static Color primarybg = Color(0xFFF6FBF4);
  static Color primarySoft = Color(0xFFfffffe);
  static Color primaryExtraSoft = Color(0xFFEFF3FC);
  static Color secondary = Color(0xFF1B1F24);
  static Color secondarySoft = Color(0xFF00214D);
  static Color secondaryExtraSoft = Color(0xFFE9E9E9);
  static Color error = Color(0xFFD00E0E);
  static Color success = Color(0xFF16AE26);
  static Color warning = Color(0xFFEB8600);
  static Color button = Color(0xFF4B8673);
}
