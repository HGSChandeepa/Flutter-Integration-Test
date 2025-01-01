import 'dart:math';

import 'package:flutter/material.dart';

class ColorToggleScreen extends StatefulWidget {
  const ColorToggleScreen({super.key});

  @override
  State<ColorToggleScreen> createState() => _ColorToggleScreenState();
}

class _ColorToggleScreenState extends State<ColorToggleScreen> {
  Color currentColor = Colors.green;
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange
  ];

  void toggleColor() {
    setState(() {
      Color newColor;
      do {
        newColor = colors[Random().nextInt(colors.length)];
      } while (newColor == currentColor);
      currentColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              color: currentColor,
              key: const Key('color_container'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleColor,
              key: const Key('toggle_button'),
              child: const Text('Toggle Color'),
            ),
          ],
        ),
      ),
    );
  }
}
