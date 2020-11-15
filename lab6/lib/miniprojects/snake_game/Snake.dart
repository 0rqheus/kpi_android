import 'DirectionEnum.dart';
import 'Rotation.dart';
import 'SnakeCell.dart';

class Snake {
  List<SnakeCell> cells;
  List<Rotation> rotationQueue = [];

  SnakeCell get head => cells[0];
  SnakeCell get tail => cells[cells.length - 1];

  void move(Direction direction, int currTime) {
    rotationQueue.add(Rotation(direction, currTime));
  }

  void updatePositions(int currTime) {
    this.rotationQueue.removeWhere(
        (rotation) => currTime - rotation.time > this.cells.length - 1);

    this.rotationQueue.forEach((rotation) =>
        this.cells[currTime - rotation.time].direction = rotation.direction);

    this.cells.forEach((cell) => cell.updateCoordinates());
  }
}