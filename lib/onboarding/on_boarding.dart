import 'package:flutter/material.dart';
import 'package:health_app/onboarding/intro_custom_widget/intro_custom_button.dart';
import 'package:health_app/onboarding/intro_screens/intro_pageOne.dart';
import 'package:health_app/onboarding/intro_screens/intro_pagethree.dart';
import 'package:health_app/onboarding/intro_screens/intro_pagetwo.dart';
import 'package:health_app/screen_routes/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  bool onFirstPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onFirstPage = (index == 0); // First Page
                onLastPage = (index == 2); // Last Page
              });
            },
            children: const [
              IntroPageOne(),
              IntroPageTwo(),
              IntroPageThree(),
            ],
          ),

          // Bottom Navigations
          Container(
            alignment: const Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (onFirstPage)
                  IntroCustomButton(
                    textTitle: 'Skip',
                    onPressed: () {
                      _controller.jumpToPage(3);
                    },
                  ),
                if (!onLastPage && !onFirstPage)
                  IntroCustomButton(
                    textTitle: 'Back',
                    onPressed: () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                if (!onLastPage)
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect:
                        const SlideEffect(activeDotColor: Color(0xFF4CAF50)),
                  ),
                IntroCustomButton(
                  textTitle: onLastPage ? 'Get Started' : 'Next',
                  onPressed: () {
                    if (onLastPage) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const HomeScreen();
                      }));
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
