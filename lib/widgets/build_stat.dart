import 'package:flutter/material.dart';

Widget buildStat(String label, int value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Text(
          "$label:",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(width: 12),
        Text(
          "$value",
          style: TextStyle(
            color: value > 0 ? Colors.redAccent : Colors.greenAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
