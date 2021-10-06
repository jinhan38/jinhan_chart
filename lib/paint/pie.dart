import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pie extends CustomPainter {

  Pie({
    required this.percentage,
    required this.textScaleFactor,
    required this.text,
  });
  int percentage = 0;
  double textScaleFactor = 1.0;
  String text = "";

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double radius = min(size.width / 2 - paint.strokeWidth / 2,
        size.height / 2 - paint.strokeWidth / 2);
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint);
    double arcAngle = 2 * pi * (percentage / 100); //정해진 각도만 그림
    paint..color = Colors.greenAccent; //호를 그릴 때는 색을 바꿔줌
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paint); //호(arc)를 그림

    drawText(canvas,size,text);
  }

  ///CustomPainter에서 텍스트를 적기 위해서는 TextPainter를 써야한다.
  ///TextPainter는 좌표를 정할 때 쓰이며 layout함수를 꼭 호출해야한다.
  void drawText(Canvas canvas, Size size, String text) {
    double fontSize = getFontSize(size, text);
    TextSpan sp = TextSpan(
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        text: text);
    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

    tp.layout();
    // 필수! 텍스트 페인터에 그려질 텍스트의 크기와 방향를 정함.
    double dx = size.width / 2 - tp.width / 2;
    double dy = size.height / 2 - tp.height / 2;

    Offset offset = Offset(dx, dy);
    tp.paint(canvas, offset);
  }

  // 화면 크기에 비례하도록 텍스트 폰트 크기를 정함.
  double getFontSize(Size size, String text) {
    return size.width / text.length * textScaleFactor;
  }

  @override
  bool shouldRepaint(Pie oldPie) {
    return oldPie.percentage != percentage;
  }
}
