import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_app/providers/history_provider.dart';
import 'package:health_app/widgets/calculator_tile.dart';
import 'package:intl/intl.dart';
// import 'package:health_app/widgets/homescreen_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bmiHistory = ref.watch(bmiDataProvider);
    final formatter = DateFormat('MMM d, yyyy hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NutriCal',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      // Body

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Column(
                children: [
                  // Calculator body

                  const Text(
                    'Calculators',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    height: 10,
                  ),
                  const SizedBox(height: 10),
                  ExpansionTile(
                    title: const Text(
                      'Calculation History',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                      'Show your previous Calculations',
                      style: TextStyle(fontSize: 12),
                    ),
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    backgroundColor: Colors.green,
                    collapsedBackgroundColor: Colors.green,
                    collapsedTextColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    children: [
                      Container(
                        height: 250,
                        color: Colors.grey[300],
                        child: bmiHistory.isEmpty
                            ? const Center(child: Text('No history yet.'))
                            : ListView.builder(
                                itemCount: bmiHistory.length,
                                itemBuilder: (context, index) {
                                  final bmiEntry = bmiHistory[index];
                                  return ListTile(
                                    title: Text(
                                      'BMI: ${bmiEntry['bmi'].toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        'Date: ${formatter.format(bmiEntry['date'])}'),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // Body Mass Index
                  CalculatorTile(
                    tileTitle: 'Body Mass Index',
                    icon: Icons.line_weight_outlined,
                    onTap: () {
                      Navigator.pushNamed(context, '/bmi');
                    },
                  ),

                  // Desirable body weight
                  CalculatorTile(
                    tileTitle: 'Desirable Body Weight',
                    icon: Icons.monitor_weight,
                    onTap: () {
                      Navigator.pushNamed(context, '/dbw');
                      // Navigator.push(
                      // context,
                      // MaterialPageRoute(builder: (context) => const SecondRoute()),
                    },
                  ),

                  // Total Energy Allowance
                  CalculatorTile(
                    tileTitle: 'Total Energy Allowance',
                    icon: Icons.energy_savings_leaf,
                    onTap: () {
                      Navigator.pushNamed(context, '/tea');
                    },
                  ),
                ],
              ),

              // Conversion body

              const SizedBox(height: 10),
              const Text(
                'Convert',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const Divider(height: 10),
              // Convert to CPF
              CalculatorTile(
                tileTitle: 'Convert to CPF (Coming Soon)',
                icon: Icons.conveyor_belt,
                onTap: () {},
              ),

              // Create Meal Plan
              CalculatorTile(
                tileTitle: 'Create Meal Plan (Coming Soon)',
                icon: Icons.create,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
