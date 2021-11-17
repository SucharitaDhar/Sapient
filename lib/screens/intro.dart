import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sapient/screens/home.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      controlsPadding: EdgeInsets.only(top: 8.0),
      isTopSafeArea: true,
      showNextButton: true,
      showDoneButton: true,
      showSkipButton: false,
      done: const Text('Done'),
      onDone: () => Get.to(() => Home()),
      next: const Icon(Icons.arrow_forward),
      pages: [
        PageViewModel(
          title: 'Welcome to Clear ToDo App',
          body: 'Press Next to Begin',
        ),
        PageViewModel(
            title: 'Clear helps you track your ToDo tasks',
            body: 'Tap on the + Button to add a task',
            image: Image.asset('assets/1.jpg')),
        PageViewModel(
            title: '',
            body: 'Tap on the Checkbox to mark a task as complete',
            image: Image.asset('assets/2.jpg')),
        PageViewModel(
            title: '',
            body: 'Tap on Edit button to edit a task',
            image: Image.asset('assets/3.jpg')),
        PageViewModel(
            title: '',
            body: 'Swipe right to delete a task',
            image: Image.asset('assets/4.jpg'))
      ],
    );
  }
}
