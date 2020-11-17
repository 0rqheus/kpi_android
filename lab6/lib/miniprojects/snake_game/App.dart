import 'package:flutter/material.dart';
import 'Game.dart';
import 'SpeedMenu.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      initialRoute: '/speed_menu',
      routes: {
        '/speed_menu': (BuildContext context) => SpeedMenu(),
        '/game': (BuildContext context) => Game(100),
      },
    );
  }
}
