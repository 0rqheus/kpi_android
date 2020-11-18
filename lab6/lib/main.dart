import 'package:flutter/material.dart';
import 'miniprojects/infection_game/InfectionGame.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 6',
      home: InfectionGame(),
    );
  }
}
