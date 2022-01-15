import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jinhan_chart/fl_line_chart/data/axis_chart_data.dart';
import 'package:jinhan_chart/fl_line_chart/data/base_chart_data.dart';
import 'package:jinhan_chart/fl_line_chart/data/line_chart.dart';
import 'package:jinhan_chart/fl_line_chart/data/line_chart_data.dart';
import 'package:zoom_widget/zoom_widget.dart';

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 1000,
                height: 500,
                child: LineChart(
                  showAvg ? avgData() : mainData(),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
                print("showAvgshowAvg : $showAvg");
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                  fontSize: 12,
                  color:
                      showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        colors: [const Color(0xff4af699)],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
                radius: 2,
                color: const Color(0xff4af699),
                strokeWidth: 1,
                strokeColor: const Color(0xff4af699));
          },
        ),
        belowBarData: BarAreaData(show: false),
        spots: [
          FlSpot(0, 0),
          FlSpot(1, 0.5),
          FlSpot(2, 1),
          FlSpot(3, 1.3),
          FlSpot(4, 2.2),
          FlSpot(5, 3.1),
          FlSpot(6, 4.5),
          FlSpot(7, 5.3),
          FlSpot(8, 5.8),
          FlSpot(9, 6.2),
          FlSpot(10, 22),
          FlSpot(11, 7.9),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        colors: [const Color(0xffaa4cfc)],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
                radius: 2,
                color: const Color(0xffaa4cfc),
                strokeWidth: 1,
                strokeColor: const Color(0xffaa4cfc));
          },
        ),
        belowBarData: BarAreaData(show: false, colors: [
          const Color(0x00aa4cfc),
        ]),
        spots: [
          FlSpot(0, 0),
          FlSpot(1, 1),
          FlSpot(2, 2),
          FlSpot(3, 3),
          FlSpot(4, 4),
          FlSpot(5, 5),
          FlSpot(6, 6),
          FlSpot(7, 7),
          FlSpot(8, 8),
          FlSpot(9, 19),
          FlSpot(10, 17),
          FlSpot(11, 20),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        colors: const [Color(0xff27b6fc)],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
                radius: 2,
                color: Colors.blue,
                strokeWidth: 1,
                strokeColor: Colors.blue);
          },
        ),
        belowBarData: BarAreaData(show: false),
        spots: [
          FlSpot(0, 0),
          FlSpot(1, 2),
          FlSpot(2, 3.5),
          FlSpot(3, 15),
          FlSpot(4, 20),
          FlSpot(5, 6),
          FlSpot(6, 7.7),
          FlSpot(7, 21),
          FlSpot(8, 16),
          FlSpot(9, 17),
          FlSpot(10, 10.9),
          FlSpot(11, 13),
        ],
      );

  LineChartData mainData() {
    return LineChartData(
      betweenBarsData: [
        BetweenBarsData(
          fromIndex: 0,
          toIndex: 2,
          colors: [Colors.red.withOpacity(0.3)],
        )
      ],
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          // getTextStyles: (context, value) =>
          // const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            print("valuevalue : $value");
            switch (value.toInt()) {
              case 0:
                return 'JAN';
              case 1:
                return 'FEB';
              case 2:
                return 'MAR';
              case 3:
                return 'APR';
              case 4:
                return 'MAY';
              case 5:
                return 'JUN';
              case 6:
                return 'JUL';
              case 7:
                return 'AUG';
              case 8:
                return 'SEP';
              case 9:
                return 'OCT';
              case 10:
                return 'NOV';
              case 11:
                return 'DEC';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1:
                return '1';
              case 2:
                return '2';
              case 3:
                return '3';
              case 4:
                return '4';
              case 5:
                return '5';
              case 6:
                return '6';
              case 7:
                return '7';
              case 8:
                return '8';
              case 9:
                return '9';
              case 10:
                return '10';
              case 11:
                return '11';
              case 12:
                return '12';
              case 13:
                return '13';
              case 14:
                return '14';
              case 15:
                return '15';
              case 16:
                return '16';
              case 17:
                return '17';
              case 18:
                return '18';
              case 19:
                return '19';
              case 20:
                return '20';
              case 21:
                return '21';
              case 22:
                return '22';
              case 23:
                return '23';
              case 24:
                return '24';
              case 25:
                return '25';
            }
            return '';
          },
          reservedSize: 25,
          margin: 12,
        ),
      ),
      // borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 25,
      lineBarsData: lineBarsData1,
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
          interval: 1,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 32,
          interval: 1,
          margin: 12,
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
