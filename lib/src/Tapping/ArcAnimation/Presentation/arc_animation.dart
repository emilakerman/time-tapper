import 'package:flutter/material.dart';

class ArcAnimation extends StatefulWidget {
  const ArcAnimation({required this.clicked, super.key});
  final bool clicked;

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
    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Define the X and Y Tweens for an arc-like motion
    _animationX = Tween<double>(begin: 75.0, end: 300.0).animate(
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

  Color color = Colors.transparent;

  void _startAnimation() {
    color = Colors.orange;
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
            child: Container(
              width: 50,
              height: 50,
              color: color,
            ),
          );
        },
      ),
    );
  }
}
