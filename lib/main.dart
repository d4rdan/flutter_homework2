import 'package:flutter/material.dart';
import 'screens/joke_types_screen.dart';

void main() {
  runApp(JokesApp());
}

class JokesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: JokeTypesScreen(),
    );
  }
}