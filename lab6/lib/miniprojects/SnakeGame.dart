import 'dart:async';
import 'dart:math' as Math;
import 'package:flutter/material.dart';

enum Direction { Up, Right, Down, Left }

class SnakeCell {
  double x;
  double y;
  Direction direction;

  SnakeCell(this.x, this.y, this.direction);

  void updateCoordinates() {
    switch (this.direction) {
      case Direction.Up:
        this.y--;
        break;
      case Direction.Down:
        this.y++;
        break;
      case Direction.Right:
        this.x++;
        break;
      case Direction.Left:
        this.x--;
        break;
      default:
    }
  }

  int positionInArr(int matrixSize) {
    return (x + matrixSize * y).toInt();
  }
}

class Rotation {
  Direction direction;
  int time;

  Rotation(this.direction, this.time);
}

class Snake {
  List<SnakeCell> cells;
  List<Rotation> rotationQueue = [];

  SnakeCell get head => cells[0];
  SnakeCell get tail => cells[cells.length - 1];

  void move(Direction direction, int currTime) {
    // if (rotationQueue.last.time == currTime) return;

    // print("direction: ${direction}");
    // print("currTime: ${currTime}");
    // print("");

    rotationQueue.add(Rotation(direction, currTime));
  }

  void updatePositions(int currTime) {
    // print("update currTime: ${currTime}");

    this.rotationQueue.removeWhere(
        (rotation) => currTime - rotation.time > this.cells.length - 1);

    print(rotationQueue.length);
    // print("");

    this.rotationQueue.forEach((rotation) =>
        this.cells[currTime - rotation.time].direction = rotation.direction);

    this.cells.forEach((cell) => cell.updateCoordinates());
  }
}

class SnakeGame extends StatefulWidget {
  @override
  _SnakeGameState createState() => _SnakeGameState();
}

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

      // print("${snake.head.x}; ${snake.head.y}");
      // print("");

      setState(() {
        _time++;
      });
    });
  }

  List<Widget> createPlayField(Snake snake) {
    var list = List.generate(fieldSize * fieldSize, (index) {
      return Container(
        child: Card(
          color: Colors.white,
        ),
      );
    });

    snake.cells.forEach((cell) {
      list[cell.positionInArr(fieldSize)] = Container(
        child: Card(
          color: Colors.teal[800],
        ),
      );
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Snake"),
        ),
        body: GestureDetector(
          // onHorizontalDragUpdate: (details) =>
          //     print("horizontal: ${details.delta}"),
          onVerticalDragUpdate: (details) =>
              print("vertical: ${details.delta}"),
          // onPanUpdate: (details) {
          //   setState(() {
          //     print(
          //         "gesture = (x: ${details.delta.dx}; y:${details.delta.dx})");

          //     if (details.delta.dx > 0) {
          //       snake.move(Direction.Right, _time);
          //     } else if (details.delta.dx < 0)
          //       snake.move(Direction.Left, _time);
          //     else if (details.delta.dy > 0)
          //       snake.move(Direction.Down, _time);
          //     else
          //       snake.move(Direction.Up, _time);
          //   });
          // },
          child: GridView.count(
            padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            crossAxisCount: 10,
            children: createPlayField(snake),
          ),
        ),
        backgroundColor: Colors.grey[300]);
  }
}
