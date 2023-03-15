import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final Color? color;
  final double fontSize;
  final FontWeight? fontWeight;

  const TextWidget({
    super.key,
    required this.label,
    required this.color,
    this.fontSize = 18,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: TextStyle(
          color: color ?? Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w500,
        ));
  }
}
