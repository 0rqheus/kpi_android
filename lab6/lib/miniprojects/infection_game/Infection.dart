import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'Cell.dart';

class Infection {
  final int cellSize = 5;
  List<Cell> infectedCells = [];
  List<Cell> immuneCells = [];

  void makeInfectionPulse(double time, Size size) {
    // immune -> healthy
    immuneCells.removeWhere((cell) => (time - cell.birthTime > 4));

    // try to infect
    tryInfectCells(time, size);

    // infeced -> immune
    infectedCells.removeWhere((cell) => (time - cell.birthTime > 6));
  }

  void tryInfectCells(double time, Size size) {
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

          if (isPossibleToInfectCell(cellToInfect, size.width))
            infectedToAdd.add(cellToInfect);
        }
      }
    });

    infectedCells.addAll(infectedToAdd);
  }

  bool isPossibleToInfectCell(Cell cell, double fieldWidth) {
    return (cell.x > 0 &&
        cell.x < fieldWidth &&
        cell.y > 0 &&
        cell.y < fieldWidth &&
        !immuneCells.contains(cell));
  }
}
