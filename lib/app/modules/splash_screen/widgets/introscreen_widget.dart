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
          title: "Welcome",
          body: "this simple intro",
          image: const Center(child: Icon(Icons.home, size: 100.0)),
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
