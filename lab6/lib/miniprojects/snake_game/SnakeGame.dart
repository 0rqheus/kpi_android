import 'dart:async';
import 'dart:math';
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

class _SnakeGameState extends State<SnakeGame> {
  final int fieldSize = 10;
  final Random rng = new Random();
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
    ];

    // iteration
    _movingTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      // update snake position
      snake.updatePositions(_time);

      // check game end
      if (snake.head.x < 0 ||
          snake.head.x > fieldSize ||
          snake.head.y < 0 ||
          snake.head.y > fieldSize) {
        print("You lose!");
        timer.cancel();
        return;
      }

      // check if we can eat food
      try {
        var head = snake.head;
        foodPositions.firstWhere((f) =>
            (f == (head.positionInArr(fieldSize) - fieldSize) &&
                head.direction == Direction.Up) ||
            (f == (head.positionInArr(fieldSize) + fieldSize) &&
                head.direction == Direction.Down) ||
            (f == (head.positionInArr(fieldSize) - 1) &&
                head.direction == Direction.Left) ||
            (f == (head.positionInArr(fieldSize) + 1) &&
                head.direction == Direction.Right));

        // @todo update rotationQueue
        switch (head.direction) {
          case Direction.Up:
            snake.cells.insert(0, SnakeCell(head.x, head.y - 1, Direction.Up));
            break;
          case Direction.Down:
            snake.cells
                .insert(0, SnakeCell(head.x, head.y + 1, Direction.Down));
            break;
          case Direction.Right:
            snake.cells
                .insert(0, SnakeCell(head.x - 1, head.y, Direction.Right));
            break;
          case Direction.Left:
            snake.cells
                .insert(0, SnakeCell(head.x + 1, head.y, Direction.Left));
            break;
          default:
            break;
        }
      } catch (err) {}

      // generate food
      if (_time % 5 == 0) {
        int freePos = null;

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
