import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'DirectionEnum.dart';
import 'Controller.dart';
import 'PlayField.dart';
import 'SnakeCell.dart';
import 'Snake.dart';

class Game extends StatefulWidget {
  final int speed;

  Game(this.speed);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final int fieldSize = 12;
  final Random rng = new Random();
  String title = "Snake length is 3";
  Timer _movingTimer;
  int _time = 0;

  Snake snake = Snake();
  List<int> foodPositions = [];

  @override
  void initState() {
    super.initState();

    // initialize
    snake.cells = [
      SnakeCell((fieldSize / 2).floor().toDouble(),
          (fieldSize / 2).floor().toDouble(), Direction.Up),
      SnakeCell((fieldSize / 2).floor().toDouble(),
          (fieldSize / 2).floor().toDouble() + 1, Direction.Up),
      SnakeCell((fieldSize / 2).floor().toDouble(),
          (fieldSize / 2).floor().toDouble() + 2, Direction.Up),
    ];

    // game routine
    _movingTimer =
        Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      print("X: ${snake.head.x}; Y: ${snake.head.y}");

      if (isGameOver()) {
        setState(() => title = "You lose!");
        timer.cancel();
        return;
      }

      snake.tryEat(foodPositions, fieldSize);

      snake.updatePositions(_time);

      generateFood();

      setState(() {
        title = "Snake length is ${snake.cells.length}";
        _time++;
      });
    });
  }

  bool isGameOver() {
    return ((snake.head.x == 0 && snake.head.direction == Direction.Left) ||
        (snake.head.x == fieldSize - 1 &&
            snake.head.direction == Direction.Right) ||
        (snake.head.y == 0 && snake.head.direction == Direction.Up) ||
        (snake.head.y == fieldSize - 1 &&
            snake.head.direction == Direction.Down));
  }

  void generateFood() {
    if (_time % 5 == 0) {
      int freePos;

      while (freePos == null) {
        var pos = rng.nextInt(100);

        try {
          snake.cells
              .firstWhere((cell) => cell.positionInArr(fieldSize) == pos);
        } catch (err) {
          freePos = pos;
        }
      }

      foodPositions.add(freePos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Playing"),
        ),
        body: Column(children: [
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
              crossAxisCount: fieldSize,
              children: createPlayField(fieldSize, snake, foodPositions),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Controller((direction) => snake.move(direction, _time)))
        ]),
        backgroundColor: Colors.grey[300]);
  }
}
