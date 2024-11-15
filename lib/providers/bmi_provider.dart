import 'package:flutter_riverpod/flutter_riverpod.dart';

class BMIState {
  final String output;
  BMIState(this.output);
}

class BMIStateNotifier extends StateNotifier<BMIState> {
  BMIStateNotifier() : super(BMIState('Display Output'));

  void calculateBMI(int feet, int inches, double weight) {
    final totalHeightInInches = (feet * 12) + inches;

    double bmi = (weight * 703) / (totalHeightInInches * totalHeightInInches);

    state = BMIState(bmi.toStringAsFixed(2));
  }

  void resetOutput() {
    state = BMIState('Display Output');
  }
}

// Define a provider
final bmiProvider = StateNotifierProvider<BMIStateNotifier, BMIState>(
  (ref) => BMIStateNotifier(),
);
