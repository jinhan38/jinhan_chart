import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Line extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0;

    Offset p1 = Offset(10.0, 10.0); //선을 그리기 위한 좌표값
    Offset p2 = Offset(size.width - 10, size.height - 10);
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
