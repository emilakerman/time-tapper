// TODO: Change this to cubit state
class Increments {
  const Increments({
    required this.points,
  });
  final int points;

  int increment(int points) => points++;

  int doubleIncrement(int points) => points = points + 2;
}
