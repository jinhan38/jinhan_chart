import 'package:flutter/material.dart';
import 'package:jinhan_chart/fl_line_chart/samples/line_chart_sample2.dart';


class FlLineChart extends StatefulWidget {
  const FlLineChart({Key? key}) : super(key: key);

  @override
  _FlLineChartState createState() => _FlLineChartState();
}

class _FlLineChartState extends State<FlLineChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fl line chart"),),
      body: LineChartSample2(),
    );
  }
}
