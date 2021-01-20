import 'package:acer/src/themes/colors.dart';
import 'package:flutter/material.dart';

Widget progressBar({
  BuildContext context,
  double width,
  double height,
  double percentage,
  Color progressColor,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    width: width,
    height: height,
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: progressColor,
          ),
          width: width * percentage,
        )
      ],
    ),
  );
}
