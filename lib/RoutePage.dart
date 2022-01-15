import 'package:get/get.dart';
import 'package:jinhan_chart/exam/RectsExample.dart';
import 'package:jinhan_chart/fl_line_chart/fl_line_chart.dart';
import 'package:jinhan_chart/time_chart/time_chart_screen.dart';
import 'package:jinhan_chart/zoom/ZoomScreen.dart';

import 'main.dart';

class RoutePage {
  static int ROUTE_DURATION_TIME = 300;

  static movePage(String pageName) => Get.toNamed(pageName);

  static getBack() => Get.back();

  static const String HOME = "/home";
  static const String LINE_SCREEN = "/lineScreen";
  static const String PIE_SCREEN = "/pieScreen";
  static const String LINE_CHART_SCREEN = "/lineChartScreen";
  static const String EXAM = "/exam";
  static const String FL_LINE_CHART = "/flLineChart";
  static const String TIME_CHART = "/timeChart";
  static const String ZOOM = "/zoom";

  static final List<GetPage> getPageList = [
    GetPage(
      name: HOME,
      page: () => MyHomePage(),
    ),
    GetPage(
      name: EXAM,
      page: () => RectsExample(),
    ),
    GetPage(
      name: FL_LINE_CHART,
      page: () => FlLineChart(),
    ),
    GetPage(
      name: TIME_CHART,
      page: () => TimeChartScreen(),
    ),
    GetPage(
      name: ZOOM,
      page: () => ZoomScreen(),
    ),
  ];
}
