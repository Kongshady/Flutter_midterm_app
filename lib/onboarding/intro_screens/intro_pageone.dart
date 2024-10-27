import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPageOne extends StatelessWidget {
  const IntroPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image Here
                SvgPicture.asset(
                  'assets/images/welcome.svg',
                  height: 300,
                  width: 100,
                ),
                const SizedBox(
                  height: 10,
                ),

                // Text Here
                const Text(
                  'Welcome to NutriCal',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Your personalized nutrition calculator.')
              ],
            ),
          )),
    );
  }
}
