import 'package:flutter/material.dart';
import 'package:jinhan_chart/custom/axis_chart/axis_chart_data.dart';
import 'package:jinhan_chart/custom/painter/line_chart_painter.dart';
import 'package:jinhan_chart/custom/painter/pd_base_chart_painter.dart';
import 'package:jinhan_chart/custom/util/utils.dart';
import 'package:jinhan_chart/custom/wrapper/canvas_wrapper.dart';

import '/custom/extensions/canvas_extension.dart';
import '/custom/extensions/paint_extension.dart';

abstract class PdAxisChartPaint<D extends AxisChartData>
    extends PdBaseChartPainter<D> {
  late Paint _gridPaint;
  late Paint _backgroundPaint;

  late Paint _rangeAnnotationPaint;

  PdAxisChartPaint() : super() {
    _gridPaint = Paint()..style = PaintingStyle.stroke;

    _backgroundPaint = Paint()..style = PaintingStyle.fill;

    _rangeAnnotationPaint = Paint()..style = PaintingStyle.fill;
  }

  @override
  void paint(BuildContext context, CanvasWrapper canvasWrapper,
      PaintHolder<D> holder) {
    super.paint(context, canvasWrapper, holder);
    _drawBackground(canvasWrapper, holder);
    _drawRangeAnnotation(canvasWrapper, holder);
    _drawGrid(canvasWrapper, holder);
  }

  void _drawBackground(CanvasWrapper canvasWrapper, PaintHolder<D> holder) {
    final data = holder.data;
    if (data.backgroundColor.opacity == 0.0) return;

    final viewSize = canvasWrapper.size;
    final usableViewSize = getChartUsableDrawSize(viewSize, holder);
    _backgroundPaint.color = data.backgroundColor;
    canvasWrapper.drawRect(
      Rect.fromLTWH(getLeftOffsetDrawSize(holder), getTopOffsetDrawSize(holder),
          usableViewSize.width, usableViewSize.height),
      _backgroundPaint,
    );
  }

  void _drawRangeAnnotation(
      CanvasWrapper canvasWrapper, PaintHolder<D> holder) {
    final data = holder.data;
    final viewSize = canvasWrapper.size;
    final chartUsableSize = getChartUsableDrawSize(viewSize, holder);

    if (data.rangeAnnotations.verticalRangeAnnotations.isNotEmpty) {
      for (var annotation in data.rangeAnnotations.verticalRangeAnnotations) {
        final topChartPadding = getTopOffsetDrawSize(holder);
        final from = Offset(
            getPixelX(annotation.x1, chartUsableSize, holder), topChartPadding);

        final bottomChartPadding =
            getExtraNeededVerticalSpace(holder) - getTopOffsetDrawSize(holder);
        final to = Offset(
          getPixelX(annotation.x2, chartUsableSize, holder),
          viewSize.height - bottomChartPadding,
        );
        final rect = Rect.fromPoints(from, to);
        _rangeAnnotationPaint.color = annotation.color;
        canvasWrapper.drawRect(rect, _rangeAnnotationPaint);
      }
    }
    if (data.rangeAnnotations.horizontalRangeAnnotations.isNotEmpty) {
      for (var annotation in data.rangeAnnotations.horizontalRangeAnnotations) {
        final leftChartPadding = getLeftOffsetDrawSize(holder);
        final from = Offset(leftChartPadding,
            getPixelY(annotation.y1, chartUsableSize, holder));

        final rightChartPadding = getExtraNeededHorizontalSpace(holder) -
            getLeftOffsetDrawSize(holder);
        final to = Offset(
          viewSize.width - rightChartPadding,
          getPixelY(annotation.y2, chartUsableSize, holder),
        );

        final rect = Rect.fromPoints(from, to);

        _rangeAnnotationPaint.color = annotation.color;

        canvasWrapper.drawRect(rect, _rangeAnnotationPaint);
      }
    }
  }

  /// With this function we can convert our [PdSpot] x
  /// to the view base axis x .
  /// the view 0, 0 is on the top/left, but the spots is bottom/left
  double getPixelX(double spotX, Size chartUsableSize, PaintHolder<D> holder) {
    final data = holder.data;
    final deltaX = data.maxX - data.minX;
    if (deltaX == 0.0) {
      return getLeftOffsetDrawSize(holder);
    }
    return (((spotX - data.minX) / deltaX) * chartUsableSize.width) +
        getLeftOffsetDrawSize(holder);
  }

  /// With this function we can convert our [FlSpot] y
  /// to the view base axis y.
  double getPixelY(double spotY, Size chartUsableSize, PaintHolder<D> holder) {
    final data = holder.data;
    final deltaY = data.maxY - data.minY;
    if (deltaY == 0.0) {
      return chartUsableSize.height + getTopOffsetDrawSize(holder);
    }

    var y = ((spotY - data.minY) / deltaY) * chartUsableSize.height;
    y = chartUsableSize.height - y;
    return y + getTopOffsetDrawSize(holder);
  }


  void _drawGrid( CanvasWrapper canvasWrapper, PaintHolder<D> holder){
    final data = holder.data;
    if(!data.gridData.show)return;

    final viewSize = canvasWrapper.size;
    final usableViewSize = getChartUsableDrawSize(viewSize, holder);

    if(data.gridData.drawVerticalLine){
      final verticalInterval = data.gridData.verticalInterval ?? getEfficientInterval(viewSize.width, data.horizontalDiff);
      var verticalSeek = data.minX + verticalInterval;

      final delta = data.horizontalDiff;
      final count = delta ~/ verticalInterval;
      final lastPosition = data.minX + (count * verticalInterval);
      final lastPositionOverlapsWithBorder = lastPosition == data.maxX;
      final end = lastPositionOverlapsWithBorder ? data.maxX - verticalInterval : data.maxX;


      while (verticalSeek <= end) {
        if (data.gridData.checkToShowVerticalLine(verticalSeek)) {
          final flLineStyle = data.gridData.getDrawingVerticalLine(verticalSeek);
          _gridPaint.color = flLineStyle.color;
          _gridPaint.strokeWidth = flLineStyle.strokeWidth;
          _gridPaint.transparentIfWidthIsZero();

          final bothX = getPixelX(verticalSeek, usableViewSize, holder);
          final x1 = bothX;
          final y1 = 0 + getTopOffsetDrawSize(holder);
          final x2 = bothX;
          final y2 = usableViewSize.height + getTopOffsetDrawSize(holder);
          canvasWrapper.drawDashedLine(
              Offset(x1, y1), Offset(x2, y2), _gridPaint, flLineStyle.dashArray);
        }
        verticalSeek += verticalInterval;
      }
    }
    if (data.gridData.drawHorizontalLine) {
      final horizontalInterval = data.gridData.horizontalInterval ??
          getEfficientInterval(viewSize.height, data.verticalDiff);
      var horizontalSeek = data.minY + horizontalInterval;

      final delta = data.verticalDiff;
      final count = delta ~/ horizontalInterval;
      final lastPosition = data.minY + (count * horizontalInterval);
      final lastPositionOverlapsWithBorder = lastPosition == data.maxY;

      final end = lastPositionOverlapsWithBorder ? data.maxY - horizontalInterval : data.maxY;

      while (horizontalSeek <= end) {
        if (data.gridData.checkToShowHorizontalLine(horizontalSeek)) {
          final flLine = data.gridData.getDrawingHorizontalLine(horizontalSeek);
          _gridPaint.color = flLine.color;
          _gridPaint.strokeWidth = flLine.strokeWidth;
          _gridPaint.transparentIfWidthIsZero();

          final bothY = getPixelY(horizontalSeek, usableViewSize, holder);
          final x1 = 0 + getLeftOffsetDrawSize(holder);
          final y1 = bothY;
          final x2 = usableViewSize.width + getLeftOffsetDrawSize(holder);
          final y2 = bothY;
          canvasWrapper.drawDashedLine(
              Offset(x1, y1), Offset(x2, y2), _gridPaint, flLine.dashArray);
        }

        horizontalSeek += horizontalInterval;
      }
    }

  }
}
