import 'package:get/get.dart';
import 'package:jinhan_chart/exam/RectsExample.dart';
import 'package:jinhan_chart/paint/line.dart';
import 'package:jinhan_chart/screen/line_chart_screen.dart';
import 'package:jinhan_chart/screen/line_screen.dart';
import 'package:jinhan_chart/screen/pie_screen.dart';

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

  static final List<GetPage> getPageList = [
    GetPage(
      name: HOME,
      page: () => MyHomePage(),
    ),
    GetPage(
      name: LINE_SCREEN,
      page: () => LineScreen(),
    ),
    GetPage(
      name: PIE_SCREEN,
      page: () => PieScreen(),
    ),
    GetPage(
      name: LINE_CHART_SCREEN,
      page: () => LineChartScreen(),
    ),
    GetPage(
      name: EXAM,
      page: () => RectsExample(),
    ),
  ];
}
