import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroscreenWidget extends StatelessWidget {
  final controller;
  IntroscreenWidget({this.controller});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: controller.keyIntroScreen,
      pages: [
        PageViewModel(
          title:
              "Sistem Presensi Guru menggunakan metode Geofencing dan Haversine Formula berbasis Mobile",
          body:
              "Sebagai solusi yang bermanfaat bagi Sekolah untuk tetap dapat melakukan Presensi tanpa menggunakan mesin Presensi sidik jari",
          image: Center(child: Image.asset('assets/images/ic_launcher.png')),
        ),
        PageViewModel(
          title:
              "Sistem Presensi Guru menggunakan metode Geofencing dan Haversine Formula berbasis Mobile",
          body: "this simple intro",
          image: Center(child: Image.asset('assets/images/ic_launcher.png')),
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
