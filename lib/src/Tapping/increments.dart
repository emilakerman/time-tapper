// ignore: file_names
class Increments {
  const Increments({
    this.points,
  });
  final int? points;

  int increment(int points) => ++points;

  int doubleIncrement(int points) => points = points + 2;
}
