import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_app/providers/dbw_provider.dart';
import 'package:health_app/widgets/custom_button.dart';
import 'package:health_app/widgets/custom_textfield.dart';

class DBWScreen extends ConsumerWidget {
  const DBWScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbwState = ref.watch(dbwProvider);
    final TextEditingController heightController = TextEditingController();
    final TextEditingController weightController = TextEditingController();

    void calculateDBW() {
      final height = double.tryParse(heightController.text) ?? 0;
      final weight = double.tryParse(weightController.text) ?? 0;
      ref.read(dbwProvider.notifier).calculateDBW(height, weight);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Desirable Body Weight',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  dbwState.result,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              // Age Group Dropdown
              _buildDropdown<String>(
                dbwState.ageGroup,
                const [
                  DropdownMenuItem(value: 'Infant', child: Text('Infant')),
                  DropdownMenuItem(value: 'Children', child: Text('Children')),
                  DropdownMenuItem(value: 'Adult', child: Text('Adult')),
                ],
                (String? newValue) {
                  if (newValue != null) {
                    ref.read(dbwProvider.notifier).updateAgeGroup(newValue);
                  }
                },
              ),

              const SizedBox(height: 10),

              // Method Dropdown
              _buildDropdown<String>(
                dbwState.method,
                const [
                  DropdownMenuItem(
                      value: 'NDAP Method', child: Text('NDAP Method')),
                  DropdownMenuItem(
                      value: 'Tanhaussers Method',
                      child: Text('Tanhaussers Method')),
                ],
                (String? newValue) {
                  if (newValue != null) {
                    ref.read(dbwProvider.notifier).updateMethod(newValue);
                  }
                },
              ),

              const SizedBox(height: 10),

              // Height TextField
              _buildTextField('Height (cm)', heightController, 3),

              const SizedBox(height: 10),

              // Weight TextField
              _buildTextField('Weight (kg)', weightController, 3),

              const SizedBox(height: 10),

              // Calculate Button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  buttonName: 'Calculate',
                  onPressed: calculateDBW,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>(
      T value, List<DropdownMenuItem<T>> items, ValueChanged<T?> onChanged) {
    return InputDecorator(
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
        child: DropdownButton<T>(
          value: value,
          style: const TextStyle(
              color: Colors.green, fontSize: 16, fontFamily: 'Poppins'),
          borderRadius: BorderRadius.circular(10),
          onChanged: onChanged,
          items: items,
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, int limitText) {
    return CustomTextfield(
      limitText: limitText,
      tfName: label,
      controllerInput: controller,
    );
  }
}
