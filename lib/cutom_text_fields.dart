// lib/custom_text_fields.dart
import 'package:flutter/material.dart';
import 'custom_keypads.dart';

class OcenyTextField extends StatelessWidget {
  final TextEditingController controller;

  OcenyTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () {
        _showOcenyKeypad(context);
      },
      decoration: InputDecoration(
        hintText: 'Tap to enter Oceny',
        // Customize the appearance of the text field here
      ),
    );
  }

  void _showOcenyKeypad(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Oceny Keypad'),
          content: OcenyKeypad(
            onKeyPressed: (value) {
              controller.text = value; // Update the text field with the selected value
              Navigator.pop(context); // Close the keypad dialog
            },
          ),
        );
      },
    );
  }
}

class ObeconscTextField extends StatelessWidget {
  final TextEditingController controller;

  ObeconscTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () {
        _showObeconscKeypad(context);
      },
      decoration: InputDecoration(
        hintText: 'Tap to enter Obeconsc',
        // Customize the appearance of the text field here
      ),
    );
  }

  void _showObeconscKeypad(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Obeconsc Keypad'),
          content: ObeconscKeypad(
            onKeyPressed: (value) {
              controller.text = value; // Update the text field with the selected value
              Navigator.pop(context); // Close the keypad dialog
            },
          ),
        );
      },
    );
  }
}
