import 'package:flutter/material.dart';
import 'package:jinhan_chart/custom/base_chart/base_chart_data.dart';
import 'package:jinhan_chart/custom/extensions/paint_extension.dart';
import 'package:jinhan_chart/custom/wrapper/canvas_wrapper.dart';

class PdBaseChartPainter<D extends BaseChartData> {
  late Paint _borderPaint;

  PdBaseChartPainter() : super() {
    _borderPaint = Paint()..style = PaintingStyle.stroke;
  }

  void paint(BuildContext context, CanvasWrapper canvasWrapper,
      PaintHolder<D> holder) {}

  _drawViewBorder(
    BuildContext context,
    CanvasWrapper canvasWrapper,
    PdBorderData borderData,
    PaintHolder<D> holder,
  ) {
    if (!borderData.show) {
      return;
    }
    final viewSize = canvasWrapper.size;
    final chartViewSize = getChartUsableDrawSize(viewSize, holder);

    final topLeft =
        Offset(getLeftOffsetDrawSize(holder), getTopOffsetDrawSize(holder));
    final topRight = Offset(getLeftOffsetDrawSize(holder) + chartViewSize.width,
        getTopOffsetDrawSize(holder));
    final bottomLeft = Offset(getLeftOffsetDrawSize(holder), getTopOffsetDrawSize(holder) + chartViewSize.height);
    final bottomRight = Offset(getLeftOffsetDrawSize(holder) + chartViewSize.width, getTopOffsetDrawSize(holder) + chartViewSize.height);

    ///draw top line
    final topBorder = borderData.border.top;
    if(topBorder.width != 0.0){
      _borderPaint.color = topBorder.color;
    _borderPaint.strokeWidth = topBorder.width;
    _borderPaint.transparentIfWidthIsZero();
    canvasWrapper.drawLine(topLeft, topRight, _borderPaint);
    }

    /// Draw Right Line
    final rightBorder = borderData.border.right;
    if(rightBorder.width != 0.0){
      _borderPaint.color = rightBorder.color;
      _borderPaint.strokeWidth = rightBorder.width;
      _borderPaint.transparentIfWidthIsZero();
      canvasWrapper.drawLine(topRight, bottomRight, _borderPaint);
    }
    /// Draw Bottom Line
    final bottomBorder = borderData.border.bottom;
    if (bottomBorder.width != 0.0) {
      _borderPaint.color = bottomBorder.color;
      _borderPaint.strokeWidth = bottomBorder.width;
      _borderPaint.transparentIfWidthIsZero();
      canvasWrapper.drawLine(bottomRight, bottomLeft, _borderPaint);
    }
    /// Draw Left Line
    final leftBorder = borderData.border.left;
    if (leftBorder.width != 0.0) {
      _borderPaint.color = leftBorder.color;
      _borderPaint.strokeWidth = leftBorder.width;
      _borderPaint.transparentIfWidthIsZero();
      canvasWrapper.drawLine(bottomLeft, topLeft, _borderPaint);
    }

  }

  Size getChartUsableDrawSize(Size viewSize, PaintHolder<D> holder) {
    final usableWidth = viewSize.width - getExtraNeededHorizontalSpace(holder);
    final usableHeight = viewSize.height - getExtraNeededVerticalSpace(holder);
    return Size(usableWidth, usableHeight);
  }

  double getExtraNeededHorizontalSpace(PaintHolder<D> holder) => 0;

  double getExtraNeededVerticalSpace(PaintHolder<D> holder) => 0;

  double getLeftOffsetDrawSize(PaintHolder<D> holder) => 0;

  double getTopOffsetDrawSize(PaintHolder<D> holder) => 0;
}

class PaintHolder<Data extends BaseChartData> {
  final Data data;
  final Data targetData;

  final double textScale;

  PaintHolder(this.data, this.targetData, this.textScale);
}
