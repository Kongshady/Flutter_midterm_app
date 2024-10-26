import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_app/providers/bmi_provider.dart';
import 'package:health_app/widgets/custom_button.dart';
import 'package:health_app/widgets/custom_display_output.dart';
import 'package:health_app/widgets/custom_textfield.dart';

class BMIScreen extends ConsumerStatefulWidget {
  const BMIScreen({super.key});

  @override
  ConsumerState<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends ConsumerState<BMIScreen> {
  final TextEditingController _feetController = TextEditingController();
  final TextEditingController _inchesController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  bool _isExpanded = false; // Variable to manage the height of the Container

  void _toggleContainer() {
    setState(() {
      _isExpanded = !_isExpanded; // Toggle the boolean value
    });
  }

  @override
  Widget build(BuildContext context) {
    final bmiState = ref.watch(bmiProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Body Mass Index',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isExpanded ? Icons.info : Icons.info_outline),
            onPressed: _toggleContainer,
          ),
        ],
      ),
      body: Column(
        children: [
          AnimatedContainer(
            color: Colors.green,
            width: double.infinity,
            height: _isExpanded ? 160 : 0,
            duration: const Duration(milliseconds: 100),
            padding: const EdgeInsets.all(20),
            child: _isExpanded
                ? const SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BMI Category',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text('Underweight = <18.5',
                            style: TextStyle(color: Colors.white)),
                        Text('Normal weight = 18.5 - 24.9',
                            style: TextStyle(color: Colors.white)),
                        Text('Over weight = 25 - 29.9',
                            style: TextStyle(color: Colors.white)),
                        Text('Obesity = BMI Greater than 30',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CustomDisplayOutput(outputName: bmiState.output),
                const SizedBox(height: 10),

                // Custom text fields for Height
                Row(
                  children: [
                    Expanded(
                      child: CustomTextfield(
                        limitText: 1,
                        tfName: 'Feet',
                        controllerInput: _feetController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextfield(
                        limitText: 2,
                        tfName: 'Inches',
                        controllerInput: _inchesController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Custom text field for Weight
                CustomTextfield(
                  limitText: 6,
                  tfName: 'Weight (Pounds)',
                  controllerInput: _weightController,
                ),
                const SizedBox(height: 10),

                // Custom Button
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    buttonName: 'Calculate',
                    onPressed: () {
                      final feet = int.tryParse(_feetController.text);
                      final inches = int.tryParse(_inchesController.text);
                      final weight = double.tryParse(_weightController.text);

                      if (feet != null &&
                          inches != null &&
                          weight != null &&
                          weight > 0) {
                        ref
                            .read(bmiProvider.notifier)
                            .calculateBMI(feet, inches, weight);
                      } else {
                        ref
                            .read(bmiProvider.notifier)
                            .resetOutput(); // Reset on invalid input
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          // Output Display

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
