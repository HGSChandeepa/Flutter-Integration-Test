import 'package:flutter/material.dart';
import 'package:integration_tester/samples/example03/screens/movies_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MovieScreen(),
    );
  }
}
