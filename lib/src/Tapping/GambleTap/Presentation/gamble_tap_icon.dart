import 'package:flutter/material.dart';

class GambleTapIcon extends StatelessWidget {
  const GambleTapIcon({this.color, this.height, this.fontSize, super.key});
  final double? height;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            color != Colors.transparent
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 40,
                  )
                : const SizedBox.shrink(),
            Image.asset(
              'assets/clickthisguy.png',
              height: height,
              width: 40,
              color: color,
            ),
          ],
        ),
        Text(
          "Gamble",
          style: TextStyle(fontSize: fontSize),
        ),
      ],
    );
  }

  factory GambleTapIcon.disabled(
    BuildContext context, {
    double? fontSize,
  }) {
    return const GambleTapIcon(
      height: 40,
      color: Colors.transparent,
      fontSize: 0,
    );
  }
}
