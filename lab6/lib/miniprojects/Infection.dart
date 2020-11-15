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

List<Cell> infectedCells = [];
List<Cell> immuneCells = [];

//
//

class Infection extends StatefulWidget {
  @override
  _InfectionState createState() => _InfectionState();
}

class _InfectionState extends State<Infection> with TickerProviderStateMixin {
  double time = 0;
  Timer _movingTimer;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      double screenWidth = MediaQuery.of(context).size.width;
      infectedCells
          .add(Cell(x: screenWidth / 2, y: screenWidth / 2, birthTime: time));
    });

    _movingTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (time != 0 && infectedCells.length == 0 && immuneCells.length == 0)
        timer.cancel();

      setState(() => time++);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: InfectionPainter(time),
    );
  }
}

//
//

class InfectionPainter extends CustomPainter {
  final int cellSize = 10;

  double time;

  InfectionPainter(this.time);

  var rng = new Math.Random();

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
    print(time);

    var offsetY = (size.height - size.width) / 2;

// draw bg
    canvas.drawRect(
        Rect.fromPoints(
            Offset(0, 0 + offsetY), Offset(size.width, size.width + offsetY)),
        bgPaint);

// cells

    immuneCells.removeWhere((cell) => (time - cell.birthTime > 4));

    // infected logic
    List<Cell> infectedToAdd = [];
    Cell toInfect;

    infectedCells.forEach((cell) {
      if (time - cell.birthTime > 6) {
        // becoming immune
        immuneCells.add(Cell(x: cell.x, y: cell.y, birthTime: time));
      } else {
        // trying to infect
        if (rng.nextBool()) {
          int direction = rng.nextInt(4);

          switch (direction) {
            case 0:
              toInfect = Cell(x: cell.x + cellSize, y: cell.y, birthTime: time);
              break;
            case 1:
              toInfect = Cell(x: cell.x - cellSize, y: cell.y, birthTime: time);
              break;
            case 2:
              toInfect = Cell(x: cell.x, y: cell.y + cellSize, birthTime: time);
              break;
            case 3:
              toInfect = Cell(x: cell.x, y: cell.y - cellSize, birthTime: time);
              break;
            default:
          }
        }
      }
    });

    if (toInfect != null)
      tryInfect(toInfect, size.width - cellSize, offsetY - cellSize);

    infectedCells.removeWhere((cell) => (time - cell.birthTime > 6));
    infectedCells.addAll(infectedToAdd);

// drawing cells
    immuneCells.forEach((cell) {
      canvas.drawRect(
          Rect.fromPoints(Offset(cell.x, cell.y + offsetY),
              Offset(cell.x + cellSize, cell.y + cellSize + offsetY)),
          immunePaint);
    });

    infectedCells.forEach((cell) {
      canvas.drawRect(
          Rect.fromPoints(Offset(cell.x, cell.y + offsetY),
              Offset(cell.x + cellSize, cell.y + cellSize + offsetY)),
          infectedPaint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void tryInfect(Cell cell, double size, double offsetY) {
    if (cell.x > 0 &&
        cell.x < size &&
        cell.y > offsetY &&
        cell.y < offsetY + size &&
        !immuneCells.contains(cell)) infectedCells.add(cell);
  }
}
