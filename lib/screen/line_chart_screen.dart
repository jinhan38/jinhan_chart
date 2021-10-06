import 'package:flutter/material.dart';
import 'package:jinhan_chart/paint/LineChart.dart';
import 'package:touchable/touchable.dart';

class LineChartScreen extends StatefulWidget {
  const LineChartScreen({Key? key}) : super(key: key);

  @override
  _LineChartScreenState createState() => _LineChartScreenState();
}

class _LineChartScreenState extends State<LineChartScreen> {
  List<double> points = [
    50,
    0,
    73,
    100,
    150,
    120,
    200,
    80,
    40,
    60,
    220,
    160,
    320,
    290,
    88,
    50,
    0,
    73,
    100,
    150,
    120,
    200,
    80,
    40,
    60,
    220,
    160,
    320,
    290,
    88
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: CanvasTouchDetector(
          builder: (context) => CustomPaint(
              size: Size(30.0 * points.length, 300),
              foregroundPainter: LineChart(
                  context: context,
                  points: points,
                  pointsSize: 15.0,
                  // 점의 크기를 정합니다.
                  lineWidth: 5.0,
                  // 선의 굵기를 정합니다.
                  lineColor: Colors.purpleAccent,
                  // 선의 색을 정합니다.
                  pointColor: Colors.purpleAccent)),
        ),
      ), // ,
    );
  }
}
