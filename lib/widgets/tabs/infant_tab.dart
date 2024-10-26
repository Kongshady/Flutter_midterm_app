import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_app/providers/tea_provider/tea_infant_provider.dart';
import 'package:health_app/widgets/custom_button.dart';
import 'package:health_app/widgets/custom_display_output.dart';
import 'package:health_app/widgets/custom_textfield.dart';

class InfantTab extends ConsumerWidget {
  const InfantTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infantTEAState = ref.watch(infantTEAProvider);
    final TextEditingController ageController = TextEditingController();
    final TextEditingController dbwController = TextEditingController();

    void calculateTEA() {
      final age = int.tryParse(ageController.text) ?? 0;
      final dbw = int.tryParse(dbwController.text) ?? 0;
      ref.read(infantTEAProvider.notifier).calculateTEA(age, dbw);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Infant',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),

            // Custom Display Output
            CustomDisplayOutput(outputName: infantTEAState.message.isNotEmpty ? infantTEAState.message : "${infantTEAState.tea} kcal/day"),

            const SizedBox(height: 10),
            CustomTextfield(
              tfName: "Age (Months)",
              controllerInput: ageController,
              limitText: 2,
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              tfName: "Desirable Body Weight (Kg)",
              controllerInput: dbwController,
              limitText: 2,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                buttonName: "Calculate",
                onPressed: calculateTEA,
              ),
            )
          ],
        ),
      ),
    );
  }
}
