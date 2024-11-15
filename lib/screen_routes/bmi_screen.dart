import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_app/providers/bmi_provider.dart';
import 'package:health_app/providers/history_provider.dart';
import 'package:health_app/widgets/custom_display_output.dart';

class BMIScreen extends ConsumerStatefulWidget {
  const BMIScreen({super.key});

  @override
  ConsumerState<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends ConsumerState<BMIScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feetController = TextEditingController();
  final TextEditingController _inchesController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  bool _isExpanded = false;

  void _toggleContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
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
            child: Form(
              // Might Remove this FORM and the key
              key: _formKey,
              child: Column(
                children: [
                  // Display Output
                  CustomDisplayOutput(outputName: bmiState.output),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _feetController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Feet',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelStyle: const TextStyle(color: Colors.green),
                          ),
                          style: const TextStyle(color: Colors.green),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your feet';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _inchesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Inches',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelStyle: const TextStyle(color: Colors.green),
                          ),
                          style: const TextStyle(color: Colors.green),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your inches';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Weight (Pounds)',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelStyle: const TextStyle(color: Colors.green),
                    ),
                    style: const TextStyle(color: Colors.green),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
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
                          ref.read(bmiProvider.notifier).resetOutput();
                        }

                        if (_formKey.currentState!.validate()) {
                          final feet = int.tryParse(_feetController.text);
                          final inches = int.tryParse(_inchesController.text);
                          final weight =
                              double.tryParse(_weightController.text);

                          if (feet != null &&
                              inches != null &&
                              weight != null &&
                              weight > 0) {
                            final totalHeightInInches = (feet * 12) + inches;

                            double bmi = (weight * 703) /
                                (totalHeightInInches * totalHeightInInches);

                            // Save BMI to history
                            ref
                                .read(bmiDataProvider.notifier)
                                .addBmiData(bmi, DateTime.now());
                          } else {
                            ref.read(bmiProvider.notifier).resetOutput();
                          }
                        }
                      },
                      child: const Text('Calculate'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
