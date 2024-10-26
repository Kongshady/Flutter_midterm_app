import 'package:flutter_riverpod/flutter_riverpod.dart';

class DBWState {
  final String result;
  final String ageGroup;
  final String method;

  DBWState({
    this.result = 'Display Output',
    this.ageGroup = 'Infant',
    this.method = 'NDAP Method',
  });
}

class DBWNotifier extends StateNotifier<DBWState> {
  DBWNotifier() : super(DBWState());

  void calculateDBW(double height, double weight) {
    if (height <= 0 || weight <= 0) {
      state = DBWState(result: 'Please enter valid height and weight.');
      return;
    }

    double desirableWeight;
    if (state.method == 'NDAP Method') {
      desirableWeight = (height * height) * 22 / 10000; // BMI of 22
    } else {
      desirableWeight = (height * height) * 24 / 10000; // BMI of 24
    }

    state = DBWState(result: '${desirableWeight.toStringAsFixed(2)} kg', ageGroup: state.ageGroup, method: state.method);
  }

  void updateAgeGroup(String newAgeGroup) {
    state = DBWState(result: state.result, ageGroup: newAgeGroup, method: state.method);
  }

  void updateMethod(String newMethod) {
    state = DBWState(result: state.result, ageGroup: state.ageGroup, method: newMethod);
  }
}

final dbwProvider = StateNotifierProvider<DBWNotifier, DBWState>((ref) {
  return DBWNotifier();
});
