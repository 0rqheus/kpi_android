import 'package:flutter/material.dart';
import 'Infection.dart';

class InfectionPainter extends CustomPainter {
  Infection infection;
  double time;

  InfectionPainter(this.infection, this.time);

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

    infection.makeInfectionPulse(time, size);

// draw bg
    canvas.drawRect(
        Rect.fromPoints(
            Offset(0, 0 + offsetY), Offset(size.width, size.width + offsetY)),
        bgPaint);

// drawing cells
    infection.immuneCells.forEach((cell) {
      canvas.drawRect(
          Rect.fromPoints(
              Offset(cell.x, cell.y + offsetY),
              Offset(cell.x + infection.cellSize,
                  cell.y + offsetY + infection.cellSize)),
          immunePaint);
    });

    infection.infectedCells.forEach((cell) {
      canvas.drawRect(
          Rect.fromPoints(
              Offset(cell.x, cell.y + offsetY),
              Offset(cell.x + infection.cellSize,
                  cell.y + offsetY + infection.cellSize)),
          infectedPaint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
