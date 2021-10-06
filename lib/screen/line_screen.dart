import 'package:flutter/material.dart';
import 'package:jinhan_chart/paint/line.dart';
import 'package:touchable/touchable.dart';

class LineScreen extends StatefulWidget {
  @override
  _LineScreenState createState() => _LineScreenState();
}

class _LineScreenState extends State<LineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: 150,
          height: 150,
          color: Colors.grey.shade300,
          //CustomPaint에서 그려지는 순서 => painter -> child -> foregroundPainter
          //사이즈의 우선순위 부모 -> child -> size
          //CustomPaint에서 size를 지정해줘도 부모 컨테이너의 width와 height를 지정하면
          // 부모 컨테이너의 사이즈를 따른다.
          child:  CustomPaint(
            painter: Line(),
            size: Size(200, 200),
          ),
        ),
      ),
    );
  }
}
