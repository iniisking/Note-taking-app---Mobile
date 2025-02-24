import 'package:flutter/material.dart';

Widget reusableText(
  String text,
  Color color,
  double fontSize,
  FontWeight weight,
  double letterSpacing, {
  textAlign = TextAlign.left,
  maxLines = 2,
  FontStyle? fontStyle,
  TextOverflow? textOverflow,
}) {
  return Text(
    text,
    maxLines: maxLines,
    textAlign: textAlign,
    overflow: textOverflow,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: weight,
      letterSpacing: letterSpacing,
    ),
  );
}
