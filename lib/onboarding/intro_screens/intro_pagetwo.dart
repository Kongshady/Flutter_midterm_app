import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPageTwo extends StatelessWidget {
  const IntroPageTwo({super.key});

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
                  'assets/images/tracking.svg',
                  height: 300,
                  width: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Effortless Tracking',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Calculate, Create and do more with Ease ')
              ],
            ),
          )),
    );
  }
}
