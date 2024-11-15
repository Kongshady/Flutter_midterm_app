import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_app/providers/tea_provider/tea_adult_provider.dart';
import 'package:health_app/widgets/custom_button.dart';
import 'package:health_app/widgets/custom_display_output.dart';
import 'package:health_app/widgets/custom_textfield.dart';

class AdultTab extends ConsumerWidget {
  const AdultTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adultTEAState = ref.watch(adultTEAProvider);
    final TextEditingController controller = TextEditingController();

    String activityDropdownValue = 'Bed rest but mobile';
    String methodDropdownValue = 'KRAUSE';
    String genderDropdownValue = 'Male';

    void calculateTEA() {
      double dbw = double.tryParse(controller.text) ?? 0;
      ref.read(adultTEAProvider.notifier).calculateTEA(dbw, activityDropdownValue, methodDropdownValue, genderDropdownValue);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Adult',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),

              // Display Output
              CustomDisplayOutput(
                outputName: adultTEAState.message.isNotEmpty ? adultTEAState.message : "${adultTEAState.tea} Kcal",
              ),

              const SizedBox(height: 10),

              CustomTextfield(
                tfName: 'Desirable Body Weight (Kg)',
                controllerInput: controller,
                limitText: 2,
              ),
              const SizedBox(height: 10),

              // Activity dropdown value
              InputDecorator(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: activityDropdownValue,
                    style: const TextStyle(color: Colors.green, fontSize: 16, fontFamily: 'Poppins'),
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        activityDropdownValue = newValue; // Change local variable
                      }
                    },
                    items: const [
                      DropdownMenuItem(value: 'Bed rest but mobile', child: Text('Bed rest but mobile')),
                      DropdownMenuItem(value: 'Sedentary', child: Text('Sedentary')),
                      DropdownMenuItem(value: 'Light', child: Text('Light')),
                      DropdownMenuItem(value: 'Moderate', child: Text('Moderate')),
                      DropdownMenuItem(value: 'Very Active', child: Text('Very Active')),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Method Dropdown Value
              InputDecorator(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: methodDropdownValue,
                    style: const TextStyle(color: Colors.green, fontSize: 16, fontFamily: 'Poppins'),
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        methodDropdownValue = newValue; // Change local variable
                      }
                    },
                    items: const [
                      DropdownMenuItem(value: 'KRAUSE', child: Text('KRAUSE')),
                      DropdownMenuItem(value: 'NDAP', child: Text('NDAP')),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Gender Dropdown Value
              InputDecorator(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: genderDropdownValue,
                    style: const TextStyle(color: Colors.green, fontSize: 16, fontFamily: 'Poppins'),
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        genderDropdownValue = newValue; // Change local variable
                      }
                    },
                    items: const [
                      DropdownMenuItem(value: 'Male', child: Text('Male')),
                      DropdownMenuItem(value: 'Female', child: Text('Female')),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  buttonName: 'Calculate TEA',
                  onPressed: calculateTEA,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
