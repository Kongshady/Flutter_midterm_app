import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_app/providers/tea_provider/tea_children_provider.dart';
import 'package:health_app/widgets/custom_button.dart';
import 'package:health_app/widgets/custom_display_output.dart';
import 'package:health_app/widgets/custom_textfield.dart';

class ChildTab extends ConsumerWidget {
  const ChildTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childTEAState = ref.watch(childTEAProvider);
    final TextEditingController ageController = TextEditingController();

    void calculateTEA() {
      final age = int.tryParse(ageController.text) ?? 0;
      ref.read(childTEAProvider.notifier).calculateTEA(age);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Child',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),

            // Display Output
            CustomDisplayOutput(outputName: childTEAState.message.isNotEmpty ? childTEAState.message : "${childTEAState.tea} Kcal"),

            const SizedBox(height: 10),
            CustomTextfield(
              tfName: "Age (Years)",
              controllerInput: ageController,
              limitText: 2,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                buttonName: 'Calculate Kcal',
                onPressed: calculateTEA,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
