// view/circle_layout_painter.dart
import 'package:flutter/material.dart';
import 'dart:math';

class CircleLayoutPainter extends CustomPainter {
  final double centerX;
  final double centerY;

  CircleLayoutPainter(this.centerX, this.centerY);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 26; i++) {
      double angle = (2 * pi / 26) * i;
      double x = centerX + 178 * cos(angle);
      double y = centerY + 178 * sin(angle);
      canvas.drawLine(Offset(centerX, centerY), Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
