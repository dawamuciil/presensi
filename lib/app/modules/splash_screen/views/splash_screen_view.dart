import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence/app/modules/splash_screen/widgets/introscreen_widget.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroscreenWidget(controller: controller),
    );
  }
}
