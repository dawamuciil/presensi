import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:presence/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final keyIntroScreen = GlobalKey<IntroductionScreenState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void goToHome() => Get.offAllNamed(Routes.LOGIN);
}
