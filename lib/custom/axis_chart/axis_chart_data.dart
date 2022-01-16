import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jinhan_chart/custom/annotation/pd_range_annotation.dart';
import 'package:jinhan_chart/custom/base_chart/base_chart_data.dart';
import 'package:jinhan_chart/custom/touch/pd_touch_data.dart';
import 'package:jinhan_chart/custom/util/pd_lerp.dart';

abstract class AxisChartData extends BaseChartData with EquatableMixin {

  final PdGridData gridData;
  final PdAxisTitleData axisTitleData;
  final PdRangeAnnotations rangeAnnotations;

  double minX, maxX;
  double minY, maxY;

  PdClipData clipData;

  Color backgroundColor;

  double get verticalDiff => maxY - minY;
  double get horizontalDiff => maxX - minX;

  bool get isHorizontalMinMaxIsZero => minX == 0 && maxX == 0;

  bool get isVerticalMinMaxIsZero => minY == 0 && maxY == 0;

  AxisChartData({
    PdGridData? gridData,
    required PdAxisTitleData axisTitleData,
    PdRangeAnnotations? rangeAnnotations,
    required double minX,
    required double maxX,
    required double minY,
    required double maxY,
    PdClipData? clipData,
    Color? backgroundColor,
    PdBorderData? borderData,
    required PdTouchData touchData,
  })  : gridData = gridData ?? PdGridData(),
        axisTitleData = axisTitleData,
        rangeAnnotations = rangeAnnotations ?? PdRangeAnnotations(),
        minX = minX,
        maxX = maxX,
        minY = minY,
        maxY = maxY,
        clipData = clipData ?? PdClipData.none(),
        backgroundColor = backgroundColor ?? Colors.transparent,
        super(borderData: borderData, touchData: touchData);

  @override
  List<Object?> get props => [
    gridData,
    axisTitleData,
    rangeAnnotations,
    minX,
    maxX,
    minY,
    maxY,
    clipData,
    backgroundColor,
    borderData,
    touchData,
  ];

}

class PdGridData with EquatableMixin {
  final bool show;

  final bool drawHorizontalLine;
  final double? horizontalInterval;
  final GetDrawingGridLine getDrawingHorizontalLine;
  final CheckToShowGrid checkToShowVerticalLine;

  final bool drawVerticalLine;
  final double? verticalInterval;
  final GetDrawingGridLine getDrawingVerticalLine;
  final CheckToShowGrid checkToShowHorizontalLine;

  PdGridData({
    bool? show,
    bool? drawHorizontalLine,
    double? horizontalInterval,
    GetDrawingGridLine? getDrawingHorizontalLine,
    CheckToShowGrid? checkToShowVerticalLine,
    bool? drawVerticalLine,
    double? verticalInterval,
    GetDrawingGridLine? getDrawingVerticalLine,
    CheckToShowGrid? checkToShowHorizontalLine,
  })
      : show = show ?? true,
        drawHorizontalLine = drawHorizontalLine ?? true,
        horizontalInterval = horizontalInterval,
        getDrawingHorizontalLine = getDrawingHorizontalLine ?? defaultGridLine,
        checkToShowHorizontalLine = checkToShowHorizontalLine ?? showAllGrids,
        drawVerticalLine = drawVerticalLine ?? true,
        verticalInterval = verticalInterval,
        getDrawingVerticalLine = getDrawingVerticalLine ?? defaultGridLine,
        checkToShowVerticalLine = checkToShowVerticalLine ?? showAllGrids {
    if (horizontalInterval == 0) {
      throw ArgumentError("PdGridData.horizontalInterval couldn't be zero");
    }
    if (verticalInterval == 0) {
      throw ArgumentError("PdGridData.verticalInterval couldn't be zero");
    }
  }

  static PdGridData lerp(PdGridData a, PdGridData b, double t) {
    return PdGridData(
      show: b.show,
      drawHorizontalLine: b.drawHorizontalLine,
      horizontalInterval:
      lerpDouble(a.horizontalInterval, b.horizontalInterval, t),
      getDrawingHorizontalLine: b.getDrawingHorizontalLine,
      checkToShowHorizontalLine: b.checkToShowHorizontalLine,
      drawVerticalLine: b.drawVerticalLine,
      verticalInterval: lerpDouble(a.verticalInterval, b.verticalInterval, t),
      getDrawingVerticalLine: b.getDrawingVerticalLine,
      checkToShowVerticalLine: b.checkToShowVerticalLine,
    );
  }

  PdGridData copyWith({
    bool? show,
    bool? drawHorizontalLine,
    double? horizontalInterval,
    GetDrawingGridLine? getDrawingHorizontalLine,
    CheckToShowGrid? checkToShowHorizontalLine,
    bool? drawVerticalLine,
    double? verticalInterval,
    GetDrawingGridLine? getDrawingVerticalLine,
    CheckToShowGrid? checkToShowVerticalLine,
  }) {
    return PdGridData(
      show: show ?? this.show,
      drawHorizontalLine: drawHorizontalLine ?? this.drawHorizontalLine,
      horizontalInterval: horizontalInterval ?? this.horizontalInterval,
      getDrawingHorizontalLine:
      getDrawingHorizontalLine ?? this.getDrawingHorizontalLine,
      checkToShowHorizontalLine:
      checkToShowHorizontalLine ?? this.checkToShowHorizontalLine,
      drawVerticalLine: drawVerticalLine ?? this.drawVerticalLine,
      verticalInterval: verticalInterval ?? this.verticalInterval,
      getDrawingVerticalLine:
      getDrawingVerticalLine ?? this.getDrawingVerticalLine,
      checkToShowVerticalLine:
      checkToShowVerticalLine ?? this.checkToShowVerticalLine,
    );
  }

  @override
  List<Object?> get props =>
      [
        show,
        drawHorizontalLine,
        horizontalInterval,
        getDrawingHorizontalLine,
        checkToShowHorizontalLine,
        drawVerticalLine,
        verticalInterval,
        getDrawingVerticalLine,
        checkToShowVerticalLine,
      ];

}

class PdLine with EquatableMixin {
  final Color color;
  final double strokeWidth;

  final List<int>? dashArray;

  PdLine({
    Color? color,
    double? strokeWidth,
    List<int>? dashArray,
  })
      : color = color ?? Colors.black,
        strokeWidth = strokeWidth ?? 2,
        dashArray = dashArray;

  static PdLine lerp(PdLine a, PdLine b, double t) {
    return PdLine(
      color: Color.lerp(a.color, b.color, t),
      strokeWidth: lerpDouble(a.strokeWidth, b.strokeWidth, t),
      dashArray: lerpIntList(a.dashArray, b.dashArray, t),
    );
  }

  PdLine copyWith({Color? color, double? strokeWidth, List<int>? dashArray}) {
    return PdLine(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      dashArray: dashArray ?? this.dashArray,
    );
  }

  @override
  List<Object?> get props =>
      [
        color,
        strokeWidth,
        dashArray,
      ];
}

typedef GetDrawingGridLine = PdLine Function(double value);

typedef CheckToShowGrid = bool Function(double value);

PdLine defaultGridLine(double value) {
  return PdLine(
    color: Colors.blueGrey,
    strokeWidth: 0.4,
    dashArray: [8, 4],
  );
}

/// Shows all lines.
bool showAllGrids(double value) {
  return true;
}

class PdAxisTitleData with EquatableMixin {
  final bool show;
  final AxisTitle leftTitle, topTitle, rightTitle, bottomTitle;

  PdAxisTitleData({
    bool? show,
    AxisTitle? leftTitle,
    AxisTitle? topTitle,
    AxisTitle? rightTitle,
    AxisTitle? bottomTitle,
  })
      : show = show ?? true,
        leftTitle = leftTitle ?? AxisTitle(),
        topTitle = topTitle ?? AxisTitle(),
        rightTitle = rightTitle ?? AxisTitle(),
        bottomTitle = bottomTitle ?? AxisTitle();


  static PdAxisTitleData lerp(PdAxisTitleData a, PdAxisTitleData b, double t) {
    return PdAxisTitleData(
      show: b.show,
      leftTitle: AxisTitle.lerp(a.leftTitle, b.leftTitle, t),
      rightTitle: AxisTitle.lerp(a.rightTitle, b.rightTitle, t),
      bottomTitle: AxisTitle.lerp(a.bottomTitle, b.bottomTitle, t),
      topTitle: AxisTitle.lerp(a.topTitle, b.topTitle, t),
    );
  }

  PdAxisTitleData copyWith({
    bool? show,
    AxisTitle? leftTitle,
    AxisTitle? topTitle,
    AxisTitle? rightTitle,
    AxisTitle? bottomTitle,
  }) {
    return PdAxisTitleData(
      show: show ?? this.show,
      leftTitle: leftTitle ?? this.leftTitle,
      topTitle: topTitle ?? this.topTitle,
      rightTitle: rightTitle ?? this.rightTitle,
      bottomTitle: bottomTitle ?? this.bottomTitle,
    );
  }

  @override
  List<Object?> get props =>
      [
        show,
        leftTitle,
        topTitle,
        rightTitle,
        bottomTitle,
      ];
}

class AxisTitle with EquatableMixin {
  final bool showTitle;

  final String titleText;

  final double reservedSize;

  final TextStyle? textStyle;

  final TextAlign textAlign;

  final TextDirection textDirection;

  final double margin;

  AxisTitle({ bool? showTitle,
    String? titleText,
    double? reservedSize,
    TextStyle? textStyle,
    TextDirection? textDirection,
    TextAlign? textAlign,
    double? margin,
  })
      : showTitle = showTitle ?? true,
        titleText = titleText ?? "",
        reservedSize = reservedSize ?? 16,
        textStyle =textStyle,
        textDirection = textDirection ?? TextDirection.ltr,
        textAlign = textAlign ?? TextAlign.center,
        margin = margin ?? 4;


  static AxisTitle lerp(AxisTitle a, AxisTitle b, double t) {
    return AxisTitle(
      showTitle: b.showTitle,
      titleText: b.titleText,
      reservedSize: lerpDouble(a.reservedSize, b.reservedSize, t),
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t),
      textDirection: b.textDirection,
      textAlign: b.textAlign,
      margin: lerpDouble(a.margin, b.margin, t),
    );
  }

  AxisTitle copyWith({
    bool? showTitle,
    String? titleText,
    double? reservedSize,
    TextStyle? textStyle,
    TextDirection? textDirection,
    TextAlign? textAlign,
    double? margin,
  }) {
    return AxisTitle(
      showTitle: showTitle ?? this.showTitle,
      titleText: titleText ?? this.titleText,
      reservedSize: reservedSize ?? this.reservedSize,
      textStyle: textStyle ?? this.textStyle,
      textDirection: textDirection ?? this.textDirection,
      textAlign: textAlign ?? this.textAlign,
      margin: margin ?? this.margin,
    );
  }

  @override
  List<Object?> get props =>
      [
        showTitle,
        titleText,
        reservedSize,
        textStyle,
        textAlign,
        margin,
      ];

}


