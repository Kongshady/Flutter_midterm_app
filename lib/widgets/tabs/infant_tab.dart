import 'package:flutter/material.dart';
import 'package:health_app/widgets/custom_button.dart';
import 'package:health_app/widgets/custom_display_output.dart';
import 'package:health_app/widgets/custom_textfield.dart';

class InfantTab extends StatefulWidget {
  const InfantTab({super.key});

  @override
  State<InfantTab> createState() => _InfantTabState();
}

class _InfantTabState extends State<InfantTab> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dbwController = TextEditingController();

  String output = 'Display Output';

  void _displayOutput() {
    final age = int.tryParse(_ageController.text);
    final dbw = int.tryParse(_dbwController.text);

    if (age != null && dbw != null && age > 0) {
      int tea;

      if (age >= 1 && age <= 6) {
        tea = 120 * dbw;
      } else if (age >= 7 && age <= 12) {
        tea = 110 * dbw;
      } else {
        setState(() {
          output = "Age must be between 1 and 12 months";
        });
        return;
      }

      setState(() {
        output = "$tea kcal/day";
      });
    } else {
      setState(() {
        output = "Please enter valid age and DBW.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(
              height: 10,
            ),

            // Custom Display Output
            CustomDisplayOutput(outputName: output),

            const SizedBox(
              height: 10,
            ),
            CustomTextfield(
              tfName: "Age (Months)",
              controllerInput: _ageController,
              limitText: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextfield(
              tfName: "Desirable body weight",
              controllerInput: _dbwController,
              limitText: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                buttonName: "Calculate",
                onPressed: () {
                  _displayOutput();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
