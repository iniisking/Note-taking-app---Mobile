import 'package:flutter/material.dart';

Widget reusableCenteredCard(
  double height,
  double width,
  Color backgroundColor,
  double borderRadius,
  Widget widget,
) {
  return Container(
    alignment: Alignment.center,
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: widget,
  );
}
