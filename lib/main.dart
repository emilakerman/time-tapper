import 'dart:async';

import 'package:flutter/material.dart';
import 'package:time_tapper/src/Tapping/ArcAnimation/Presentation/arc_animation.dart';
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
bool startAnimation = false;
bool autoClickerEnabled = false;
Color? autoClickerIconColor;
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
                                    if (doubleTapActivated) return;
                                    startAnimation = false;
                                    doubleTapActivated = true;
                                  }),
                              child: DoubleTapIcon(
                                  color: doubleTapActivated
                                      ? Colors.transparent.withOpacity(0.2)
                                      : null))
                          : DoubleTapIcon.disabled(context),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeaderText(),
                    Stack(
                      children: [
                        Cube(
                            key: _cubeKey,
                            click: () {
                              setState(() {
                                startAnimation = true;
                                points = increments.increment(
                                    points, doubleTapActivated);
                              });
                            }),
                        ArcAnimation(
                          clicked: startAnimation,
                          isReversed: false,
                        ),
                        if (doubleTapActivated)
                          ArcAnimation(
                            clicked: startAnimation,
                            isReversed: true,
                          ),
                      ],
                    ),
                    PointsWidget(points: points),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      points >= 20
                          ? InkWell(
                              onTap: () {
                                autoClickerEnabled = !autoClickerEnabled;
                                if (!autoClickerEnabled) {
                                  setState(() {
                                    autoClickerIconColor = null;
                                  });
                                } else {
                                  setState(() {
                                    autoClickerIconColor =
                                        Colors.transparent.withOpacity(0.2);
                                  });
                                }
                                autoClicker();
                              },
                              child: AutoTapIcon(color: autoClickerIconColor),
                            )
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

  final GlobalKey<_CubeState> _cubeKey = GlobalKey<_CubeState>();

  void autoClicker() {
    // if (autoClickerEnabled) return;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!autoClickerEnabled) {
        timer.cancel();
        return;
      }
      setState(() {
        points = increments.increment(points, doubleTapActivated);
        _cubeKey.currentState?._animateCube();
      });
    });
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "",
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

  void _animateCube() {
    controller.forward().whenComplete(() {
      controller.reverse();
      size = 200;
    });
    setState(() {
      size = size + 10;
    });
  }

  void _startAnimation() {
    _animateCube();
    widget.click();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _startAnimation();
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
