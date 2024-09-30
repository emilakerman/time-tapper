import 'package:flutter/material.dart';

class AutoTapIcon extends StatelessWidget {
  const AutoTapIcon({this.height, this.fontSize, super.key});
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
          "Auto",
          style: TextStyle(fontSize: fontSize),
        ),
      ],
    );
  }

  factory AutoTapIcon.disabled(
    BuildContext context, {
    double? fontSize,
  }) {
    return const AutoTapIcon(
      height: 0,
      fontSize: 0,
    );
  }
}
