import 'package:flutter/material.dart';

class AutoTapIcon extends StatelessWidget {
  const AutoTapIcon({this.color, this.height, this.fontSize, super.key});
  final double? height;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            color != null
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
