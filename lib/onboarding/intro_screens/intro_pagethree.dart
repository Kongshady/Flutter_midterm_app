import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPageThree extends StatelessWidget {
  const IntroPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/insights.svg',
                  height: 300,
                  width: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Personalized Insights',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Get tailored recommendations for your health')
              ],
            ),
          )),
    );
  }
}
