import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:touchable/touchable.dart';

class LineChart extends CustomPainter {
  BuildContext? context;
  List<double>? points;
  double? lineWidth;
  double? pointsSize;
  Color? lineColor;
  Color? pointColor;
  int? maxValueIndex;
  int? minValueIndex;
  double? fontSize = 18.0;

  LineChart(
      {required this.context,
      required this.points,
      this.pointsSize,
      this.lineWidth,
      this.lineColor,
      this.pointColor});

  TouchyCanvas? myCanvas;
  Canvas? canvas;

  @override
  void paint(Canvas canvas, Size size) {
    this.canvas = canvas;
    myCanvas = TouchyCanvas(context!, canvas);

    print("ffff poinst : ${points!.length}");
    List<Offset> offsets = getCoordinates(points!, size);
    drawBackground(myCanvas!, size);

    drawText(myCanvas!, offsets);

    drawLines(myCanvas!, size, offsets); // 구한 좌표를 바탕으로 선을 그립니다.
  }

  void drawBackground(TouchyCanvas canvas, Size size) {
    double spacing = 30.0;
    Paint paint = Paint()..color = Colors.yellow;
    myCanvas!
        .drawRect(Rect.fromLTRB(0, 0, spacing * points!.length, 300), paint,
            onTapDown: (details) {
      RenderBox box = context!.findRenderObject() as RenderBox;
      final offset = box.globalToLocal(details.globalPosition);
      print("위치 : ${offset.dx}, ${offset.dy}");
      // drawTextValue(this.canvas!, offset.dx.toString(), offset, true);
    }, onTapUp: (details) {
      print("tapUp");
    });
  }

  void drawPoints(TouchyCanvas canvas, Size size, List<Offset> offsets) {
    Paint paint = Paint()
      ..color = pointColor!
      ..strokeCap = StrokeCap.round
      ..strokeWidth = pointsSize!;
    canvas.drawPoints(PointMode.points, offsets, paint);
  }

  void drawLines(TouchyCanvas canvas, Size size, List<Offset> offsets) {
    Paint paint = Paint()
      ..color = lineColor!
      ..strokeWidth = lineWidth!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    double dx = offsets[0].dx;
    double dy = offsets[0].dy;
    path.moveTo(dx, dy);
    offsets.map((offset) => path.lineTo(offset.dx, offset.dy)).toList();

    canvas.drawPath(path, paint);
  }

  List<Offset> getCoordinates(List<double> points, Size size) {
    List<Offset> coordinates = [];

    // 좌표를 일정 간격으로 벌리기 위한 값
    double spacing = size.width / (points.length - 1);

    //데이터 중 최대값
    double maxY = points.reduce(max);
    //데이터 중 최초값
    double minY = points.reduce(min);

    double bottomPadding = fontSize! * 2; // 텍스트가 들어갈 패딩(아랫쪽)을 구합니다.
    double topPadding = bottomPadding * 2; // 텍스트가 들어갈 패딩(위쪽)을 구합니다.
    double h = size.height - topPadding; // 패딩을 제외한 화면의 높이를 구합니다.

    for (int index = 0; index < points.length; index++) {
      double x = spacing * index; //x축 좌표값
      double normalizedY =
          points[index] / maxY; // 정규화한다. 정규화란 [0 ~ 1] 사이가 나오게 값을 변경하는 것.
      double y =
          getYPos(h, bottomPadding, normalizedY); // Y축 좌표를 구합니다. 높이에 비례한 값입니다.

      Offset coord = Offset(x, y);
      coordinates.add(coord);
      findMaxIndex(
          points, index, maxY, minY); // 텍스트(최대값)를 적기 위해, 최대값의 인덱스를 구해놓습니다.
      findMinIndex(
          points, index, maxY, minY); // 텍스트(최소값)를 적기 위해, 최대값의 인덱스를 구해놓습니다.
    }
    return coordinates;
  }

  double getYPos(double h, double bottomPadding, double normalizedY) =>
      (h + bottomPadding) - (normalizedY * h);

  void findMaxIndex(List<double> points, int index, double maxY, double minY) {
    if (maxY == points[index]) {
      maxValueIndex = index;
    }
  }

  void findMinIndex(List<double> points, int index, double maxY, double minY) {
    if (minY == points[index]) {
      minValueIndex = index;
    }
  }

  void drawText(TouchyCanvas canvas, List<Offset> offsets) {
    String maxValue = points!.reduce(max).toString();
    String minValue = points!.reduce(min).toString();
    for (int i = 0; i < offsets.length; i++) {
      // drawTextValue(canvas, points![i].toString(), offsets[i], true);
    }
    // offsets.map((offset) =>   drawTextValue(canvas,maxValue,offset,true));
    // drawTextValue(canvas,minValue,offsets[minValueIndex!],false);
    // drawTextValue(canvas,maxValue,offsets[maxValueIndex!],true);
  }

  void drawTextValue(Canvas canvas, String text, Offset pos, bool textUpward) {
    TextSpan maxSpan = TextSpan(
        style: TextStyle(
            fontSize: fontSize,
            color: Colors.black,
            fontWeight: FontWeight.bold),
        text: text);
    TextPainter tp =
        TextPainter(text: maxSpan, textDirection: TextDirection.ltr);
    tp.layout();
    double y = textUpward
        ? -tp.height * 1.5
        : tp.height * 0.5; // 텍스트의 방향을 고려해 y축 값을 보정
    double dx = pos.dx - tp.width / 2; //텍스트 위치 x축 보정
    double dy = pos.dy + y;

    Offset offset = Offset(dx, dy);
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
