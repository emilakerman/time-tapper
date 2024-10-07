class PointFixer {
  String formatPoints(int points) {
    String fixedPoints = "";
    switch (points) {
      case >= 1000000 && < 2000000:
        fixedPoints = "+1M";
        break;
      case >= 2000000 && < 3000000:
        fixedPoints = "+2M";
        break;
      case >= 3000000 && < 4000000:
        fixedPoints = "+3M";
        break;
      case >= 4000000 && < 5000000:
        fixedPoints = "+4M";
        break;
      case >= 5000000 && < 6000000:
        fixedPoints = "+5M";
        break;
      case >= 6000000 && < 7000000:
        fixedPoints = "+6M";
        break;
      case >= 7000000 && < 8000000:
        fixedPoints = "+7M";
        break;
      case >= 8000000 && < 9000000:
        fixedPoints = "+8M";
        break;
      case >= 9000000 && < 10000000:
        fixedPoints = "+9M";
        break;
      case >= 10000000 && < 20000000:
        fixedPoints = "+10M";
        break;
      case >= 20000000 && < 30000000:
        fixedPoints = "+20M";
        break;
      case >= 30000000 && < 40000000:
        fixedPoints = "+30M";
        break;
      case >= 40000000 && < 50000000:
        fixedPoints = "+40M";
        break;
      case >= 50000000 && < 60000000:
        fixedPoints = "+50M";
        break;
      case >= 60000000 && < 70000000:
        fixedPoints = "+60M";
        break;
      case >= 70000000 && < 80000000:
        fixedPoints = "+70M";
        break;
      case >= 80000000 && < 90000000:
        fixedPoints = "+80M";
        break;
      case >= 90000000 && < 100000000:
        fixedPoints = "+90M";
        break;
      case >= 100000000:
        fixedPoints = "+100M";
        break;
      default:
        fixedPoints = points.toString();
    }

    return fixedPoints.toString();
  }
}
