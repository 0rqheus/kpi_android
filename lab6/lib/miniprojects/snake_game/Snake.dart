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

    this.rotationQueue.forEach((rotation) {
      this.cells[currTime - rotation.time].direction = rotation.direction;
    });

    this.cells.forEach((cell) => cell.updateCoordinates());
  }

  bool tryEat(List<int> foodPositions, int fieldSize) {
    try {
      foodPositions.firstWhere((food) => food == head.positionInArr(fieldSize));

      switch (tail.direction) {
        case Direction.Up:
          this.cells.add(SnakeCell(tail.x, tail.y + 1, Direction.Up));
          break;
        case Direction.Down:
          this.cells.add(SnakeCell(tail.x, tail.y - 1, Direction.Down));
          break;
        case Direction.Right:
          this.cells.add(SnakeCell(tail.x - 1, tail.y, Direction.Right));
          break;
        case Direction.Left:
          this.cells.add(SnakeCell(tail.x + 1, tail.y, Direction.Left));
          break;
        default:
          break;
      }

      return true;
    } catch (err) {}

    return false;
  }
}
