import 'package:flutter/cupertino.dart';

class AppColor {
  static LinearGradient primaryGradient = LinearGradient(
    colors: [primary, const Color(0xFF16A085)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Color primary = const Color(0xFF4B8673);
  static Color card = const Color(0xFF4B8673);
  static Color buttontext = const Color.fromARGB(255, 28, 62, 188);
  static Color primarybg = const Color(0xFFF6FBF4);
  static Color primarySoft = const Color(0xFFfffffe);
  static Color primaryExtraSoft = const Color(0xFFEFF3FC);
  static Color secondary = const Color(0xFF1B1F24);
  static Color secondarySoft = const Color(0xFF00214D);
  static Color secondaryExtraSoft = const Color(0xFFE9E9E9);
  static Color error = const Color(0xFFD00E0E);
  static Color success = const Color(0xFF16AE26);
  static Color warning = const Color(0xFFEB8600);
  static Color button = const Color(0xFF4B8673);
}
