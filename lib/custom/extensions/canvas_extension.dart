import 'dart:ui';

import 'package:jinhan_chart/custom/extensions/path_extension.dart';
import 'package:jinhan_chart/custom/wrapper/canvas_wrapper.dart';

/// Defines extensions on the [CanvasWrapper]
extension DashedLine on CanvasWrapper {
  /// Draws a dashed line from passed in offsets
  void drawDashedLine(Offset from, Offset to, Paint painter, List<int>? dashArray) {
    var path = Path();
    path.moveTo(from.dx, from.dy);
    path.lineTo(to.dx, to.dy);
    path = path.toDashedPath(dashArray);
    drawPath(path, painter);
  }
}
