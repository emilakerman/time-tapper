import 'dart:math';

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

  // 50/50 Gamble to either double current points or lose them all.
  int gamblePoints(int points) {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    if (randomNumber >= 50) {
      return points * 2;
    } else {
      return 0;
    }
  }
}
