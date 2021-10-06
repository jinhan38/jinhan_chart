import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'RoutePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "jinhan chart",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutePage.HOME,
        getPages: RoutePage.getPageList);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("차트"),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Center(
      child: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(RoutePage.LINE_SCREEN);
                },
                child: Text("라인")),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(RoutePage.PIE_SCREEN);
                },
                child: Text("파이")),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(RoutePage.LINE_CHART_SCREEN);
                },
                child: Text("라인차트")),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(RoutePage.EXAM);
                },
                child: Text("예제")),
          ],
        ),
      ),
    );
  }
}
