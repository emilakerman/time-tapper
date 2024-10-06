import 'dart:math';

class Increments {
  const Increments({
    this.points,
  });
  final int? points;

  int increment(int points, bool isDouble) {
    if (!isDouble) {
      return tap(points);
    } else {
      return doubleTap(points);
    }
  }

  int tap(int points) => ++points;

  int doubleTap(int points) => points = points + 2;

  int superTap(int points) => points = (points * 1.4).round();

  int megaTap(int points) => points = (points * 1.7).round();

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
