import 'dart:math';

import 'package:flutter/material.dart';

class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  Color currentColor = Colors.green;
  int clickCount = 0;
  bool isTextVisible = true;
  String selectedSize = 'Medium';

  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange
  ];

  void toggleColor() {
    setState(() {
      currentColor = colors[Random().nextInt(colors.length)];
      clickCount++;
    });
  }

  void toggleTextVisibility() {
    setState(() {
      isTextVisible = !isTextVisible;
    });
  }

  void changeSize(String? newSize) {
    if (newSize != null) {
      setState(() {
        selectedSize = newSize;
      });
    }
  }

  double getContainerSize() {
    switch (selectedSize) {
      case 'Small':
        return 100;
      case 'Large':
        return 300;
      default:
        return 200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isTextVisible)
              Text(
                'Click Count: $clickCount',
                key: const Key('click_counter'),
                style: const TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: getContainerSize(),
              height: getContainerSize(),
              decoration: BoxDecoration(color: currentColor),
              key: const Key('color_container'),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              key: const Key('size_dropdown'),
              value: selectedSize,
              items: ['Small', 'Medium', 'Large']
                  .map((size) => DropdownMenuItem(
                        value: size,
                        child: Text(size),
                      ))
                  .toList(),
              onChanged: changeSize,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: toggleColor,
                  key: const Key('toggle_button'),
                  child: const Text('Toggle Color'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: toggleTextVisibility,
                  key: const Key('visibility_button'),
                  child: const Text('Toggle Counter'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
