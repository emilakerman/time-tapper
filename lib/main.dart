import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int points = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.lightBlue[100]!,
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HeaderText(),
                Cube(click: () => setState(() => points++)),
                PointsWidget(points: points),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Wow nice job!",
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
      ),
    );
  }
}

class PointsWidget extends StatefulWidget {
  const PointsWidget({
    this.points,
    super.key,
  });
  final int? points;
  @override
  State<PointsWidget> createState() => _PointsWidgetState();
}

class _PointsWidgetState extends State<PointsWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.points.toString(),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
    );
  }
}

class Cube extends StatefulWidget {
  const Cube({required this.click, super.key});
  final VoidCallback click;
  @override
  State<Cube> createState() => _CubeState();
}

class _CubeState extends State<Cube> with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 100))
    ..addListener(() {
      setState(() {});
    });
  late final animation = Tween<Matrix4>(
          begin: Matrix4.translationValues(0, 15, 0), end: Matrix4.identity())
      .animate(controller);

  double size = 200;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          controller.forward().whenComplete(() {
            controller.reverse();
            size = 200;
          });
          widget.click();
          setState(() {
            size = size + 10;
          });
        },
        child: AnimatedContainer(
          transform: animation.value,
          duration: controller.duration!,
          child: Image.asset(
            'assets/clickthisguy.png',
            height: size,
            width: size,
          ),
        ),
      ),
    );
  }
}
