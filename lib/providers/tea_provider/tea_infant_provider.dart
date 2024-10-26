import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfantTEAState {
  final String message;
  final int tea;

  InfantTEAState({this.message = '', this.tea = 0});
}

class InfantTEANotifier extends StateNotifier<InfantTEAState> {
  InfantTEANotifier() : super(InfantTEAState());

  void calculateTEA(int age, int dbw) {
    if (age < 1 || age > 12) {
      state = InfantTEAState(message: "Age must be between 1 and 12 months");
      return;
    }
    
    if (dbw <= 0) {
      state = InfantTEAState(message: "Please enter valid DBW.");
      return;
    }

    int tea;
    if (age >= 1 && age <= 6) {
      tea = 120 * dbw;
    } else if (age >= 7 && age <= 12) {
      tea = 110 * dbw;
    } else {
      tea = 0;
    }

    state = InfantTEAState(message: '', tea: tea);
  }
}

final infantTEAProvider = StateNotifierProvider<InfantTEANotifier, InfantTEAState>((ref) {
  return InfantTEANotifier();
});
