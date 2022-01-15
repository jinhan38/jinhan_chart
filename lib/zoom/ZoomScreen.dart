import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';

class ZoomScreen extends StatefulWidget {
  const ZoomScreen({Key? key}) : super(key: key);

  @override
  _ZoomScreenState createState() => _ZoomScreenState();
}

class _ZoomScreenState extends State<ZoomScreen> {
  double x = 0;
  double y = 0;
  double _zoom = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("zoomScreen"),
      ),
      body: Container(child: zoomWidget()),
    );
  }

  Widget zoomWidget() {
    return Zoom(
        maxZoomWidth: 1000,
        maxZoomHeight: 1000,
        onTap: () {
          print("Widget clicked");
        },
        onPositionUpdate: (Offset position) {
          print(position);
        },
        onScaleUpdate: (double scale, double zoom) {
          print("$scale  $zoom");
        },
        child: Center(
          child: Text("Happy zoom!!"),
        ));
  }
}
