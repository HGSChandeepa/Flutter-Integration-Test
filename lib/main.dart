import 'package:flutter/material.dart';
import 'package:integration_tester/samples/example03/screens/movies_screen.dart';
import 'package:integration_tester/samples/example03/services/movie_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MovieScreen(
        movieService: MovieService(),
      ),
    );
  }
}
