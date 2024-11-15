import 'package:flutter_riverpod/flutter_riverpod.dart';

class BMIData extends StateNotifier<List<Map<String, dynamic>>> {  
  BMIData() : super([]);  

  void addBmiData(double bmi, DateTime date) {  
    state = [...state, {'bmi': bmi, 'date': date}];  
  }  

  //Might Add methods to clear history, etc.  
}  

final bmiDataProvider = StateNotifierProvider<BMIData, List<Map<String, dynamic>>>((ref) {  
  return BMIData();  
});