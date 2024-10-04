import 'package:flutter/material.dart';

class ArcAnimation extends StatefulWidget {
  const ArcAnimation({
    required this.isReversed,
    required this.clicked,
    super.key,
  });
  final bool clicked;
  final bool isReversed;

  @override
  ArcAnimationState createState() => ArcAnimationState();
}

class ArcAnimationState extends State<ArcAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationX;
  late Animation<double> _animationY;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    initializeCoin();
  }

  void initializeCoin() {
    double endX;

    if (widget.isReversed) {
      endX = -300.0;
    } else {
      endX = 300.0;
    }

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animationX = Tween<double>(begin: 75.0, end: endX).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _animationY = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 100.0, end: -100.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -100.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color? color = Colors.transparent;

  void _startAnimation() {
    color = null;
    _controller.forward().whenComplete(() {
      color = Colors.transparent;
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clicked) {
      _startAnimation();
    }
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_animationX.value, _animationY.value),
            child: Image.asset(
              'assets/coin_gif.gif',
              height: 50,
              width: 50,
              color: color,
            ),
          );
        },
      ),
    );
  }
}
