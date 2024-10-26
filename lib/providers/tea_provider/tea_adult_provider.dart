import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdultTEAState {
  final String message;
  final int tea;

  AdultTEAState({this.message = '', this.tea = 0});
}

class AdultTEANotifier extends StateNotifier<AdultTEAState> {
  AdultTEANotifier() : super(AdultTEAState());

  void calculateTEA(double dbw, String activity, String method, String gender) {
    if (dbw <= 0) {
      state = AdultTEAState(message: "Invalid Desirable Body Weight.");
      return;
    }

    double tea;

    if (method == 'KRAUSE') {

      tea = gender == 'Male' ? 66 + (13.7 * dbw) + (5 * 175) - (6.8 * 30) :
            655 + (9.6 * dbw) + (1.8 * 165) - (4.7 * 30);
    } else {
      tea = gender == 'Male' ? 900 + (10 * dbw) : 700 + (8 * dbw);
    }

    switch (activity) {
      case 'Bed rest but mobile':
        tea *= 1.2; // Sedentary
        break;
      case 'Sedentary':
        tea *= 1.4; // Lightly active
        break;
      case 'Light':
        tea *= 1.55; // Moderately active
        break;
      case 'Moderate':
        tea *= 1.7; // Very active
        break;
      case 'Very Active':
        tea *= 2.0; // Extra active
        break;
      default:
        state = AdultTEAState(message: "Invalid activity level.");
        return;
    }

    state = AdultTEAState(message: '', tea: tea.toInt());
  }
}

final adultTEAProvider = StateNotifierProvider<AdultTEANotifier, AdultTEAState>((ref) {
  return AdultTEANotifier();
});
