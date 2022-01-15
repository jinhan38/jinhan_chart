import 'package:flutter/material.dart';
import 'package:time_chart/time_chart.dart';

class TimeChartScreen extends StatefulWidget {
  const TimeChartScreen({Key? key}) : super(key: key);

  @override
  _TimeChartScreenState createState() => _TimeChartScreenState();
}

class _TimeChartScreenState extends State<TimeChartScreen> {
  // Data must be sorted.
  final data = [
    DateTimeRange(
      start: DateTime(2021, 2, 24, 23, 15),
      end: DateTime(2021, 2, 25, 7, 30),
    ),
    DateTimeRange(
      start: DateTime(2021, 2, 22, 1, 55),
      end: DateTime(2021, 2, 22, 9, 12),
    ),
    DateTimeRange(
      start: DateTime(2021, 2, 20, 0, 25),
      end: DateTime(2021, 2, 20, 7, 34),
    ),
    DateTimeRange(
      start: DateTime(2021, 2, 17, 21, 23),
      end: DateTime(2021, 2, 18, 4, 52),
    ),
    DateTimeRange(
      start: DateTime(2021, 2, 13, 6, 32),
      end: DateTime(2021, 2, 13, 13, 12),
    ),
    DateTimeRange(
      start: DateTime(2021, 2, 1, 9, 32),
      end: DateTime(2021, 2, 1, 15, 22),
    ),
    DateTimeRange(
      start: DateTime(2021, 1, 22, 12, 10),
      end: DateTime(2021, 1, 22, 16, 20),
    ),
  ];
  final sizedBox = const SizedBox(height: 16);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("timeChart")
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Weekly time chart'),
              TimeChart(
                data: data,
                viewMode: ViewMode.weekly,
              ),
              sizedBox,
              const Text('Monthly time chart'),
              TimeChart(
                data: data,
                viewMode: ViewMode.monthly,
              ),
              sizedBox,
              const Text('Weekly amount chart'),
              TimeChart(
                data: data,
                chartType: ChartType.amount,
                viewMode: ViewMode.weekly,
                barColor: Colors.deepPurple,
              ),
              sizedBox,
              const Text('Monthly amount chart'),
              TimeChart(
                data: data,
                chartType: ChartType.amount,
                viewMode: ViewMode.monthly,
                barColor: Colors.deepPurple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
