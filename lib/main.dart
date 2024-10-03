import 'package:flutter/material.dart';
import 'package:time_tapper/src/Tapping/AutoTapper/Presentation/auto_tap_icon.dart';
import 'package:time_tapper/src/Tapping/DoubleTap/Presentation/double_tap_icon.dart';
import 'package:time_tapper/src/Tapping/increments.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

int points = 0;
bool doubleTapActivated = false;
Increments increments = const Increments();

class _MainAppState extends State<MainApp> {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      points >= 10
                          ? InkWell(
                              onTap: () => setState(() {
                                    doubleTapActivated = true;
                                  }),
                              child: const DoubleTapIcon())
                          : DoubleTapIcon.disabled(context),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeaderText(),
                    Cube(click: () {
                      setState(() {
                        if (!doubleTapActivated) {
                          points = increments.increment(points);
                        } else {
                          points = increments.doubleIncrement(points);
                        }
                      });
                    }),
                    PointsWidget(points: points),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      points >= 20
                          ? const AutoTapIcon()
                          : AutoTapIcon.disabled(context),
                    ],
                  ),
                ),
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
