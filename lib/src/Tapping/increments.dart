// ignore: file_names
class Increments {
  const Increments({
    this.points,
  });
  final int? points;

  int increment(int points, bool isDouble) {
    if (!isDouble) {
      return incrementSingle(points);
    } else {
      return doubleIncrement(points);
    }
  }

  int incrementSingle(int points) => ++points;

  int doubleIncrement(int points) => points = points + 2;
}
