import 'package:flutter/material.dart';

class BaselineText extends StatelessWidget {
  final String text;
  final double baseline;
  final double fontSize;
  final Color color;

  const BaselineText({
    super.key,
    required this.text,
    this.baseline = 35,
    this.fontSize = 18,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Baseline(
      baseline: baseline,
      baselineType: TextBaseline.alphabetic,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'italian',
          fontSize: fontSize,
          color: color,
        ),
      ),
    );
  }
}
