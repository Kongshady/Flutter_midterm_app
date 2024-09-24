import 'package:flutter/material.dart';

class CalculatorTile extends StatelessWidget {
  const CalculatorTile({super.key, required this.tileTitle, this.icon});
  final String tileTitle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        tileTitle,
        style: const TextStyle(fontSize: 15),
      ),
      onTap: () {},
    );
  }
}
