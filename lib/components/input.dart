// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboard;
  const Input({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hint,
      ),
      keyboardType: keyboard,
      style: TextStyle(fontSize: 24.0),
    );
  }
}
