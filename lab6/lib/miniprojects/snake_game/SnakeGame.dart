import 'dart:async';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'DirectionEnum.dart';
import 'Controller.dart';
import 'PlayField.dart';
import 'SnakeCell.dart';
import 'Snake.dart';

class SnakeGame extends StatefulWidget {
  @override
  _SnakeGameState createState() => _SnakeGameState();
}

// @todo generate food & increase size
class _SnakeGameState extends State<SnakeGame> {
  final int fieldSize = 10;
  int _time = 0;
  Timer _movingTimer;

  Snake snake = Snake();

  @override
  void initState() {
    super.initState();

    // initialize
    snake.cells = [
      SnakeCell((fieldSize / 2).floor().toDouble(),
          (fieldSize / 2).floor().toDouble(), Direction.Up),
      SnakeCell((fieldSize / 2).floor().toDouble(),
          (fieldSize / 2).floor().toDouble() + 1, Direction.Up),
    ];

    // iteration
    _movingTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      snake.updatePositions(_time);

      if (snake.head.x < 0 ||
          snake.head.x > fieldSize ||
          snake.head.y < 0 ||
          snake.head.y > fieldSize) {
        print("You lose!");
        timer.cancel();
        return;
      }

      setState(() => _time++);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Snake"),
        ),
        body: Column(children: [
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
              crossAxisCount: 10,
              children: createPlayField(fieldSize, snake),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Controller((direction) => snake.move(direction, _time)))
        ]),
        backgroundColor: Colors.grey[300]);
  }
}
