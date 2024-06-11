// lib/custom_keypads.dart
import 'package:flutter/material.dart';

class OcenyKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;


  OcenyKeypad({required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    // make two columns of buttons
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var key in ['1'])
              ElevatedButton(
                onPressed: () => onKeyPressed(key),
                child: Text(key),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var key in ['2-', '2', '2+'])
              ElevatedButton(
                onPressed: () => onKeyPressed(key),
                child: Text(key),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var key in ['3-', '3', '3+'])
              ElevatedButton(
                onPressed: () => onKeyPressed(key),
                child: Text(key),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var key in ['4-', '4', '4+'])
              ElevatedButton(
                onPressed: () => onKeyPressed(key),
                child: Text(key),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var key in ['5-', '5', '5+'])
              ElevatedButton(
                onPressed: () => onKeyPressed(key),
                child: Text(key),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var key in ['6'])
              ElevatedButton(
                // add "Navigator.pop(context);" to close the dialog
                onPressed: () => onKeyPressed(key),
                child: Text(key),
              ),
          ],
        ),
      ],
    );
}}


class ObeconscKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;

  ObeconscKeypad({required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var key in ['ob', 'nb', 'brak'])
          ElevatedButton(
            onPressed: () => onKeyPressed(key),
            child: Text(key),
          ),
      ],
    );
  }
}
