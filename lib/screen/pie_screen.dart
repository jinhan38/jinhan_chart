import 'package:flutter/material.dart';
import 'package:jinhan_chart/paint/pie.dart';

List<double> points = [50, 0, 73, 100, 150, 120, 200, 80];

class PieScreen extends StatelessWidget {
  const PieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                height: 350,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: CustomPaint(
                  size: Size(200,200),
                  painter: Pie(percentage: 60, textScaleFactor: 2,text: "심플 파이차트"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
