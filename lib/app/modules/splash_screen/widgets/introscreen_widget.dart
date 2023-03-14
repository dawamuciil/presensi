import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroscreenWidget extends StatelessWidget {
  final controller;
  const IntroscreenWidget({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: controller.keyIntroScreen,
      pages: [
        PageViewModel(
          title:
              "Sistem Presensi Guru menggunakan metode Geofencing dan Haversine Formula berbasis Mobile",
          body: "Integrated with geofencing & Haversine Formula",
          image: Center(child: Image.asset('assets/images/ic_launcher.png')),
        ),
        PageViewModel(
          title: "Using (GPS)",
          body: "Distance From Office",
          image: Center(child: Image.asset('assets/images/tag.png')),
        ),
      ],
      onDone: () => controller.goToHome(),
      onSkip: () => controller.goToHome(),
      showNextButton: true,
      showDoneButton: true,
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Text("Next"),
      done: const Text("Done"),
    );
  }
}
