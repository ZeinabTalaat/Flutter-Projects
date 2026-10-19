import 'package:flutter/material.dart';

class Dice extends StatelessWidget {
  final int value;

  const Dice({super.key,
    required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
      child: Text(
        '$value',
        style: const TextStyle(fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}