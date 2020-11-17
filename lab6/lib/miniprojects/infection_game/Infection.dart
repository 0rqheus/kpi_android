import 'dart:async';
import 'dart:math' as Math;
import 'package:flutter/material.dart';

class Cell {
  double x;
  double y;
  double birthTime;

  Cell({this.x, this.y, this.birthTime});

  bool operator ==(cell) =>
      cell is Cell && cell.x == this.x && cell.y == this.y;

  @override
  int get hashCode => (this.x * this.y ~/ this.birthTime).toInt();
}

class Infection {
  final int cellSize = 10;
  List<Cell> infectedCells = [];
  List<Cell> immuneCells = [];

  void makeInfectionPulse(double time, Size size) {
    // immune -> healthy
    immuneCells.removeWhere((cell) => (time - cell.birthTime > 4));

    // infeced -> immune
    infectedCells.removeWhere((cell) => (time - cell.birthTime > 6));

    // try to infect
    tryInfectCells(time, size);
  }

  void tryInfectCells(double time, Size size) {
    var offsetY = (size.height - size.width) / 2;
    var rng = new Math.Random();
    List<Cell> infectedToAdd = [];

    infectedCells.forEach((cell) {
      if (time - cell.birthTime > 6) {
        // becoming immune
        immuneCells.add(Cell(x: cell.x, y: cell.y, birthTime: time));
      } else {
        // trying to infect
        if (rng.nextBool()) {
          Cell cellToInfect;
          int direction = rng.nextInt(4);

          switch (direction) {
            case 0:
              cellToInfect =
                  Cell(x: cell.x + cellSize, y: cell.y, birthTime: time);
              break;
            case 1:
              cellToInfect =
                  Cell(x: cell.x - cellSize, y: cell.y, birthTime: time);
              break;
            case 2:
              cellToInfect =
                  Cell(x: cell.x, y: cell.y + cellSize, birthTime: time);
              break;
            case 3:
              cellToInfect =
                  Cell(x: cell.x, y: cell.y - cellSize, birthTime: time);
              break;
            default:
          }

          if (isPossibleToInfectCell(cellToInfect, size.width, offsetY))
            infectedToAdd.add(cellToInfect);
        }
      }
    });

    infectedCells.addAll(infectedToAdd);
  }

  bool isPossibleToInfectCell(Cell cell, double fieldWidth, double offsetY) {
    var cellOffset = offsetY - cellSize;
    var maxFieldWidth = fieldWidth - cellSize;

    return (cell.x > 0 &&
        cell.x < maxFieldWidth &&
        cell.y > cellOffset &&
        cell.y < cellOffset + maxFieldWidth &&
        !immuneCells.contains(cell));
  }
}

//

class InfectionGame extends StatefulWidget {
  @override
  _InfectionGameState createState() => _InfectionGameState();
}

class _InfectionGameState extends State<InfectionGame>
    with TickerProviderStateMixin {
  double time = 0;
  Timer _movingTimer;

  Infection infection = Infection();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      double screenWidth = MediaQuery.of(context).size.width;
      infection.infectedCells
          .add(Cell(x: screenWidth / 2, y: screenWidth / 2, birthTime: time));
    });

    _movingTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (time != 0 &&
          infection.infectedCells.length == 0 &&
          infection.immuneCells.length == 0) timer.cancel();

      setState(() => time++);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: InfectionPainter(infection),
    );
  }
}

//

class InfectionPainter extends CustomPainter {
  Infection infection;

  InfectionPainter(this.infection);

  Paint bgPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  Paint immunePaint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;

  Paint infectedPaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    var offsetY = (size.height - size.width) / 2;

// draw bg
    canvas.drawRect(
        Rect.fromPoints(
            Offset(0, 0 + offsetY), Offset(size.width, size.width + offsetY)),
        bgPaint);

// cells

// drawing cells
    infection.immuneCells.forEach((cell) {
      canvas.drawRect(
          Rect.fromPoints(
              Offset(cell.x, cell.y + offsetY),
              Offset(cell.x + infection.cellSize,
                  cell.y + infection.cellSize + offsetY)),
          immunePaint);
    });

    infection.infectedCells.forEach((cell) {
      canvas.drawRect(
          Rect.fromPoints(
              Offset(cell.x, cell.y + offsetY),
              Offset(cell.x + infection.cellSize,
                  cell.y + infection.cellSize + offsetY)),
          infectedPaint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
