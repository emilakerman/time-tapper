import 'package:flutter/material.dart';

class DoubleTapIcon extends StatelessWidget {
  const DoubleTapIcon({this.height, this.fontSize, super.key});
  final double? height;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/clickthisguy.png',
          height: height,
          width: 40,
        ),
        Text(
          "Double",
          style: TextStyle(fontSize: fontSize),
        ),
      ],
    );
  }

  factory DoubleTapIcon.disabled(
    BuildContext context, {
    double? fontSize,
  }) {
    return const DoubleTapIcon(
      height: 0,
      fontSize: 0,
    );
  }
}
