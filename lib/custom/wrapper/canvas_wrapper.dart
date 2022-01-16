import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:jinhan_chart/custom/painter/line_chart_painter.dart';
import 'package:jinhan_chart/fl_line_chart/util/utils.dart';

class CanvasWrapper {
  final Canvas canvas;
  final Size size;

  CanvasWrapper(this.canvas, this.size);

  drawRRect(RRect rRect, Paint paint) => canvas.drawRRect(rRect, paint);

  save() => canvas.save();

  restore() => canvas.restore();

  clipRect(
    Rect rect, {
    ui.ClipOp clipOn = ui.ClipOp.intersect,
    bool doAntiAlias = true,
  }) =>
      canvas.clipRect(rect, clipOp: clipOn, doAntiAlias: doAntiAlias);

  translate(double dx, double dy) => canvas.translate(dx, dy);

  rotate(double radians) => canvas.rotate(radians);

  drawPath(Path path, Paint paint) => canvas.drawPath(path, paint);

  saveLayer(Rect bounds, Paint paint) => canvas.saveLayer(bounds, paint);

  drawPicture(ui.Picture picture) => canvas.drawPicture(picture);

  drawImage(ui.Image image, Offset offset, Paint paint) =>
      canvas.drawImage(image, offset, paint);

  clipPath(Path path, {bool doAntiAlias = true}) =>
      canvas.clipPath(path, doAntiAlias: doAntiAlias);

  drawRect(Rect rect, Paint paint) => canvas.drawRect(rect, paint);

  drawLine(Offset p1, Offset p2, Paint paint) => canvas.drawLine(p1, p2, paint);

  drawCircle(Offset center, double radius, Paint paint) =>
      canvas.drawCircle(center, radius, paint);

  drawArc(Rect rect, double startAngle, double sweepAngle, bool useCenter,
          Paint paint) =>
      canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);

  drawText(TextPainter textPainter, Offset offset, [double? rotateAngle]) {
    if (rotateAngle == null) {
      textPainter.paint(canvas, offset);
    } else {
      drawRotated(
          size: textPainter.size,
          drawOffset: offset,
          angle: rotateAngle,
          drawCallback: () {
            textPainter.paint(canvas, offset);
          });
    }
  }

  drawDot(PdDotPainter painter, PdSpot spot, Offset offset) {
    painter.draw(canvas, spot, offset);
  }

  drawRotated({
    required Size size,
    Offset rotationOffset = const Offset(0, 0),
    Offset drawOffset = const Offset(0, 0),
    required double angle,
    required void Function() drawCallback,
  }) {
    save();
    translate(
      rotationOffset.dx + drawOffset.dx + size.width / 2,
      rotationOffset.dy + drawOffset.dy + size.height / 2,
    );
    rotate(radians(angle));
    translate(
      -drawOffset.dx - size.width / 2,
      -drawOffset.dy - size.height / 2,
    );
    drawCallback();
    restore();
  }
}
