import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChildTEAState {
  final String message;
  final int tea;

  ChildTEAState({this.message = '', this.tea = 0});
}

class ChildTEANotifier extends StateNotifier<ChildTEAState> {
  ChildTEANotifier() : super(ChildTEAState());

  void calculateTEA(int age) {
    if (age <= 0) {
      state = ChildTEAState(message: "Invalid Age input.");
      return;
    }

    int tea = 1000 + (100 * age);
    state = ChildTEAState(message: '', tea: tea);
  }
}

final childTEAProvider = StateNotifierProvider<ChildTEANotifier, ChildTEAState>((ref) {
  return ChildTEANotifier();
});
