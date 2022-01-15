import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jinhan_chart/fl_line_chart/data/base_chart_data.dart';
import 'package:jinhan_chart/fl_line_chart/util/lerp.dart';
import 'package:jinhan_chart/fl_line_chart/util/utils.dart';

abstract class AxisChartData extends BaseChartData with EquatableMixin {
  final FlGridData gridData;
  final FlAxisTitleData axisTitleData;
  final RangeAnnotations rangeAnnotations;

  double minX, maxX;
  double minY, maxY;

  /// clip the chart to the border (prevent draw outside the border)
  FlClipData clipData;

  /// A background color which is drawn behind th chart.
  Color backgroundColor;

  /// Difference of [maxY] and [minY]
  double get verticalDiff => maxY - minY;

  /// Difference of [maxX] and [minX]
  double get horizontalDiff => maxX - minX;

  /// Returns true if [minX] and [maxX] both are zero
  bool get isHorizontalMinMaxIsZero => minX == 0 && maxX == 0;

  /// Returns true if [minY] and [maxY] both are zero
  bool get isVerticalMinMaxIsZero => minY == 0 && maxY == 0;

  AxisChartData({
    FlGridData? gridData,
    required FlAxisTitleData axisTitleData,
    RangeAnnotations? rangeAnnotations,
    required double minX,
    required double maxX,
    required double minY,
    required double maxY,
    FlClipData? clipData,
    Color? backgroundColor,
    FlBorderData? borderData,
    required FlTouchData touchData,
  })  : gridData = gridData ?? FlGridData(),
        axisTitleData = axisTitleData,
        rangeAnnotations = rangeAnnotations ?? RangeAnnotations(),
        minX = minX,
        maxX = maxX,
        minY = minY,
        maxY = maxY,
        clipData = clipData ?? FlClipData.none(),
        backgroundColor = backgroundColor ?? Colors.transparent,
        super(borderData: borderData, touchData: touchData);

  /// Used for equality check, see [EquatableMixin].
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

class FlAxisTitleData with EquatableMixin {
  final bool show;
  final AxisTitle leftTitle, topTitle, rightTitle, bottomTitle;

  FlAxisTitleData({
    bool? show,
    AxisTitle? leftTitle,
    AxisTitle? topTitle,
    AxisTitle? rightTitle,
    AxisTitle? bottomTitle,
  })  : show = show ?? true,
        leftTitle = leftTitle ?? AxisTitle(reservedSize: 16),
        topTitle = topTitle ?? AxisTitle(reservedSize: 16),
        rightTitle = rightTitle ?? AxisTitle(reservedSize: 16),
        bottomTitle = bottomTitle ?? AxisTitle(reservedSize: 16);

  /// Lerps a [FlAxisTitleData] based on [t] value, check [Tween.lerp].
  static FlAxisTitleData lerp(FlAxisTitleData a, FlAxisTitleData b, double t) {
    return FlAxisTitleData(
      show: b.show,
      leftTitle: AxisTitle.lerp(a.leftTitle, b.leftTitle, t),
      rightTitle: AxisTitle.lerp(a.rightTitle, b.rightTitle, t),
      bottomTitle: AxisTitle.lerp(a.bottomTitle, b.bottomTitle, t),
      topTitle: AxisTitle.lerp(a.topTitle, b.topTitle, t),
    );
  }

  /// Copies current [FlAxisTitleData] to a new [FlAxisTitleData],
  /// and replaces provided values.
  FlAxisTitleData copyWith({
    bool? show,
    AxisTitle? leftTitle,
    AxisTitle? topTitle,
    AxisTitle? rightTitle,
    AxisTitle? bottomTitle,
  }) {
    return FlAxisTitleData(
      show: show ?? this.show,
      leftTitle: leftTitle ?? this.leftTitle,
      topTitle: topTitle ?? this.topTitle,
      rightTitle: rightTitle ?? this.rightTitle,
      bottomTitle: bottomTitle ?? this.bottomTitle,
    );
  }

  /// Used for equality check, see [EquatableMixin].
  @override
  List<Object?> get props => [
        show,
        leftTitle,
        topTitle,
        rightTitle,
        bottomTitle,
      ];
}

/// Holds data for showing title of each side of charts.
class AxisTitle with EquatableMixin {
  /// You can show or hide it using [showTitle],
  final bool showTitle;

  /// Determines the showing text.
  final String titleText;

  /// Defines how much space it needed to draw.
  final double reservedSize;

  /// Determines the style of this title, if it is null, we try to read TextStyle from theme.
  final TextStyle? textStyle;

  /// Determines alignment of this title.
  final TextAlign textAlign;

  /// Determines direction of this title
  final TextDirection textDirection;

  /// Determines margin of this title.
  final double margin;

  /// You can show or hide it using [showTitle],
  /// [titleText] determines the text, and
  /// [textStyle] determines the style of this.
  /// [textAlign] determines alignment of this title,
  /// [textDirection] determines direction of this title.
  /// [BaseChartPainter] uses [reservedSize] for assigning
  /// a space for drawing this side title, it used for
  /// some calculations.
  /// [margin] determines margin of this title.
  AxisTitle({
    bool? showTitle,
    String? titleText,
    double? reservedSize,
    TextStyle? textStyle,
    TextDirection? textDirection,
    TextAlign? textAlign,
    double? margin,
  })  : showTitle = showTitle ?? false,
        titleText = titleText ?? '',
        reservedSize = reservedSize ?? 14,
        textStyle = textStyle,
        textDirection = textDirection ?? TextDirection.ltr,
        textAlign = textAlign ?? TextAlign.center,
        margin = margin ?? 4;

  /// Lerps an [AxisTitle] based on [t] value, check [Tween.lerp].
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

  /// Copies current [AxisTitle] to a new [AxisTitle],
  /// and replaces provided values.
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

  /// Used for equality check, see [EquatableMixin].
  @override
  List<Object?> get props => [
        showTitle,
        titleText,
        reservedSize,
        textStyle,
        textAlign,
        margin,
      ];
}

///그리드 데이터를 가지고 있다.
class FlGridData with EquatableMixin {
  ///가로 세로 전부를 보일지 말지 결정
  final bool show;

  final bool drawHorizontalLine;

  ///가로 라인의 사이를 결정해주고, null인경우에는 자동 계산
  final double? horizontalInterval;

  /// Gives you a y value, and gets a [FlLine] that represents specified line.
  final GetDrawingGridLine getDrawingHorizontalLine;

  /// Gives you a x value, and gets a boolean that determines showing or hiding specified line.
  final CheckToShowGrid checkToShowHorizontalLine;

  /// Determines showing or hiding all vertical lines.
  final bool drawVerticalLine;

  /// Determines interval between vertical lines, left it null to be auto calculated.
  final double? verticalInterval;

  /// Gives you a x value, and gets a [FlLine] that represents specified line.
  final GetDrawingGridLine getDrawingVerticalLine;

  /// Gives you a x value, and gets a boolean that determines showing or hiding specified line.
  final CheckToShowGrid checkToShowVerticalLine;

  /// Responsible for rendering grid lines behind the content of charts,
  /// [show] determines showing or hiding all grids,
  FlGridData({
    bool? show,
    bool? drawHorizontalLine,
    double? horizontalInterval,
    GetDrawingGridLine? getDrawingHorizontalLine,
    CheckToShowGrid? checkToShowHorizontalLine,
    bool? drawVerticalLine,
    double? verticalInterval,
    GetDrawingGridLine? getDrawingVerticalLine,
    CheckToShowGrid? checkToShowVerticalLine,
  })  : show = show ?? true,
        drawHorizontalLine = drawHorizontalLine ?? true,
        horizontalInterval = horizontalInterval,
        getDrawingHorizontalLine = getDrawingHorizontalLine ?? defaultGridLine,
        checkToShowHorizontalLine = checkToShowHorizontalLine ?? showAllGrids,
        drawVerticalLine = drawVerticalLine ?? true,
        verticalInterval = verticalInterval,
        getDrawingVerticalLine = getDrawingVerticalLine ?? defaultGridLine,
        checkToShowVerticalLine = checkToShowVerticalLine ?? showAllGrids {
    if (horizontalInterval == 0) {
      throw ArgumentError("FlGridData.horizontalInterval couldn't be zero");
    }
    if (verticalInterval == 0) {
      throw ArgumentError("FlGridData.verticalInterval couldn't be zero");
    }
  }

  /// Lerps a [FlGridData] based on [t] value, check [Tween.lerp].
  static FlGridData lerp(FlGridData a, FlGridData b, double t) {
    return FlGridData(
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

  /// Copies current [FlGridData] to a new [FlGridData],
  /// and replaces provided values.
  FlGridData copyWith({
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
    return FlGridData(
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

  /// Used for equality check, see [EquatableMixin].
  @override
  List<Object?> get props => [
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

class FlLine with EquatableMixin {
  ///라인 컬러
  final Color color;

  ///라인의 두께
  final double strokeWidth;

  ///점선
  final List<int>? dashArray;

  FlLine({
    Color? color,
    double? strokeWidth,
    List<int>? dashArray,
  })  : color = color ?? Colors.black,
        strokeWidth = strokeWidth ?? 2,
        dashArray = dashArray;

  static FlLine lerp(FlLine a, FlLine b, double t) {
    return FlLine(
      color: Color.lerp(a.color, b.color, t),
      strokeWidth: lerpDouble(a.strokeWidth, b.strokeWidth, t),
      dashArray: lerpIntList(a.dashArray, b.dashArray, t),
    );
  }

  FlLine copyWith({
    Color? color,
    double? strokeWidth,
    List<int>? dashArray,
  }) {
    return FlLine(
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      dashArray: dashArray ?? this.dashArray,
    );
  }

  @override
  List<Object?> get props => [
        color,
        strokeWidth,
        dashArray,
      ];
}

/// Determines the appearance of specified line.
///
/// It gives you an axis value (horizontal or vertical),
/// you should pass a [FlLine] that represents style of specified line.
typedef GetDrawingGridLine = FlLine Function(double value);

/// Determines showing or hiding specified line.
typedef CheckToShowGrid = bool Function(double value);

/// Returns a grey line for all values.
FlLine defaultGridLine(double value) {
  return FlLine(
    color: Colors.blueGrey,
    strokeWidth: 0.4,
    dashArray: [8, 4],
  );
}

/// Shows all lines.
bool showAllGrids(double value) {
  return true;
}

class RangeAnnotations with EquatableMixin {
  final List<HorizontalRangeAnnotation> horizontalRangeAnnotations;
  final List<VerticalRangeAnnotation> verticalRangeAnnotations;

  /// Axis based charts can annotate some horizontal and vertical regions,
  /// using [horizontalRangeAnnotations], and [verticalRangeAnnotations] respectively.
  RangeAnnotations({
    List<HorizontalRangeAnnotation>? horizontalRangeAnnotations,
    List<VerticalRangeAnnotation>? verticalRangeAnnotations,
  })  : horizontalRangeAnnotations = horizontalRangeAnnotations ?? const [],
        verticalRangeAnnotations = verticalRangeAnnotations ?? const [];

  /// Lerps a [RangeAnnotations] based on [t] value, check [Tween.lerp].
  static RangeAnnotations lerp(
      RangeAnnotations a, RangeAnnotations b, double t) {
    return RangeAnnotations(
      horizontalRangeAnnotations: lerpHorizontalRangeAnnotationList(
          a.horizontalRangeAnnotations, b.horizontalRangeAnnotations, t),
      verticalRangeAnnotations: lerpVerticalRangeAnnotationList(
          a.verticalRangeAnnotations, b.verticalRangeAnnotations, t),
    );
  }

  /// Copies current [RangeAnnotations] to a new [RangeAnnotations],
  /// and replaces provided values.
  RangeAnnotations copyWith({
    List<HorizontalRangeAnnotation>? horizontalRangeAnnotations,
    List<VerticalRangeAnnotation>? verticalRangeAnnotations,
  }) {
    return RangeAnnotations(
      horizontalRangeAnnotations:
          horizontalRangeAnnotations ?? this.horizontalRangeAnnotations,
      verticalRangeAnnotations:
          verticalRangeAnnotations ?? this.verticalRangeAnnotations,
    );
  }

  /// Used for equality check, see [EquatableMixin].
  @override
  List<Object?> get props => [
        horizontalRangeAnnotations,
        verticalRangeAnnotations,
      ];
}

/// Defines an annotation region in y (vertical) axis.
class HorizontalRangeAnnotation with EquatableMixin {
  /// Determines starting point in vertical (y) axis.
  final double y1;

  /// Determines ending point in vertical (y) axis.
  final double y2;

  /// Fills the area with this color.
  final Color color;

  /// Annotates a horizontal region from most left to most right point of the chart, and
  /// from [y1] to [y2], and fills the area with [color].
  HorizontalRangeAnnotation({
    required double y1,
    required double y2,
    Color? color,
  })  : y1 = y1,
        y2 = y2,
        color = color ?? Colors.white;

  /// Lerps a [HorizontalRangeAnnotation] based on [t] value, check [Tween.lerp].
  static HorizontalRangeAnnotation lerp(
      HorizontalRangeAnnotation a, HorizontalRangeAnnotation b, double t) {
    return HorizontalRangeAnnotation(
      y1: lerpDouble(a.y1, b.y1, t)!,
      y2: lerpDouble(a.y2, b.y2, t)!,
      color: Color.lerp(a.color, b.color, t),
    );
  }

  /// Copies current [HorizontalRangeAnnotation] to a new [HorizontalRangeAnnotation],
  /// and replaces provided values.
  HorizontalRangeAnnotation copyWith({
    double? y1,
    double? y2,
    Color? color,
  }) {
    return HorizontalRangeAnnotation(
      y1: y1 ?? this.y1,
      y2: y2 ?? this.y2,
      color: color ?? this.color,
    );
  }

  /// Used for equality check, see [EquatableMixin].
  @override
  List<Object?> get props => [
        y1,
        y2,
        color,
      ];
}

/// Defines an annotation region in x (horizontal) axis.
class VerticalRangeAnnotation with EquatableMixin {
  /// Determines starting point in horizontal (x) axis.
  final double x1;

  /// Determines ending point in horizontal (x) axis.
  final double x2;

  /// Fills the area with this color.
  final Color color;

  /// Annotates a vertical region from most bottom to most top point of the chart, and
  /// from [x1] to [x2], and fills the area with [color].
  VerticalRangeAnnotation({
    required double x1,
    required double x2,
    Color? color,
  })  : x1 = x1,
        x2 = x2,
        color = color ?? Colors.white;

  /// Lerps a [VerticalRangeAnnotation] based on [t] value, check [Tween.lerp].
  static VerticalRangeAnnotation lerp(
      VerticalRangeAnnotation a, VerticalRangeAnnotation b, double t) {
    return VerticalRangeAnnotation(
      x1: lerpDouble(a.x1, b.x1, t)!,
      x2: lerpDouble(a.x2, b.x2, t)!,
      color: Color.lerp(a.color, b.color, t),
    );
  }

  /// Copies current [VerticalRangeAnnotation] to a new [VerticalRangeAnnotation],
  /// and replaces provided values.
  VerticalRangeAnnotation copyWith({
    double? x1,
    double? x2,
    Color? color,
  }) {
    return VerticalRangeAnnotation(
      x1: x1 ?? this.x1,
      x2: x2 ?? this.x2,
      color: color ?? this.color,
    );
  }

  /// Used for equality check, see [EquatableMixin].
  @override
  List<Object?> get props => [
        x1,
        x2,
        color,
      ];
}


/// Represents a conceptual position in cartesian (axis based) space.
class FlSpot with EquatableMixin {
  final double x;
  final double y;

  /// [x] determines cartesian (axis based) horizontally position
  /// 0 means most left point of the chart
  ///
  /// [y] determines cartesian (axis based) vertically position
  /// 0 means most bottom point of the chart
  FlSpot(double x, double y)
      : x = x,
        y = y;

  /// Copies current [FlSpot] to a new [FlSpot],
  /// and replaces provided values.
  FlSpot copyWith({
    double? x,
    double? y,
  }) {
    return FlSpot(
      x ?? this.x,
      y ?? this.y,
    );
  }

  ///Prints x and y coordinates of FlSpot list
  @override
  String toString() {
    return '(' + x.toString() + ', ' + y.toString() + ')';
  }

  /// Used for splitting lines, or maybe other concepts.
  static FlSpot nullSpot = FlSpot(double.nan, double.nan);

  /// Determines if [x] or [y] is null.
  bool isNull() => this == nullSpot;

  /// Determines if [x] and [y] is not null.
  bool isNotNull() => !isNull();

  /// Used for equality check, see [EquatableMixin].
  @override
  List<Object?> get props => [
    x,
    y,
  ];

  /// Lerps a [FlSpot] based on [t] value, check [Tween.lerp].
  static FlSpot lerp(FlSpot a, FlSpot b, double t) {
    if (a == FlSpot.nullSpot) {
      return b;
    }

    if (b == FlSpot.nullSpot) {
      return a;
    }

    return FlSpot(
      lerpDouble(a.x, b.x, t)!,
      lerpDouble(a.y, b.y, t)!,
    );
  }
}


/// Holds data for showing titles on each side of charts (a title per each axis value).
class FlTitlesData with EquatableMixin {
  final bool show;

  final SideTitles leftTitles, topTitles, rightTitles, bottomTitles;

  /// [show] determines showing or hiding all titles,
  /// [leftTitles], [topTitles], [rightTitles], [bottomTitles] defines
  /// side titles of left, top, right, bottom sides respectively.
  FlTitlesData({
    bool? show,
    SideTitles? leftTitles,
    SideTitles? topTitles,
    SideTitles? rightTitles,
    SideTitles? bottomTitles,
  })  : show = show ?? true,
        leftTitles = leftTitles ?? SideTitles(reservedSize: 40, showTitles: true),
        topTitles = topTitles ?? SideTitles(reservedSize: 6, showTitles: true),
        rightTitles = rightTitles ?? SideTitles(reservedSize: 40, showTitles: true),
        bottomTitles = bottomTitles ?? SideTitles(reservedSize: 6, showTitles: true);

  /// Lerps a [FlTitlesData] based on [t] value, check [Tween.lerp].
  static FlTitlesData lerp(FlTitlesData a, FlTitlesData b, double t) {
    return FlTitlesData(
      show: b.show,
      leftTitles: SideTitles.lerp(a.leftTitles, b.leftTitles, t),
      rightTitles: SideTitles.lerp(a.rightTitles, b.rightTitles, t),
      bottomTitles: SideTitles.lerp(a.bottomTitles, b.bottomTitles, t),
      topTitles: SideTitles.lerp(a.topTitles, b.topTitles, t),
    );
  }

  /// Copies current [FlTitlesData] to a new [FlTitlesData],
  /// and replaces provided values.
  FlTitlesData copyWith({
    bool? show,
    SideTitles? leftTitles,
    SideTitles? topTitles,
    SideTitles? rightTitles,
    SideTitles? bottomTitles,
  }) {
    return FlTitlesData(
      show: show ?? this.show,
      leftTitles: leftTitles ?? this.leftTitles,
      topTitles: topTitles ?? this.topTitles,
      rightTitles: rightTitles ?? this.rightTitles,
      bottomTitles: bottomTitles ?? this.bottomTitles,
    );
  }

  /// Used for equality check, see [EquatableMixin].
  @override
  List<Object?> get props => [
    show,
    leftTitles,
    topTitles,
    rightTitles,
    bottomTitles,
  ];
}

/// Holds data for showing each side titles (a title per each axis value).
class SideTitles with EquatableMixin {
  final bool showTitles;
  final GetTitleFunction getTitles;
  final double reservedSize;
  final GetTitleTextStyleFunction getTextStyles;
  final TextDirection textDirection;
  final double margin;
  final double? interval;
  final double rotateAngle;
  final CheckToShowTitle checkToShowTitle;

  /// It draws some title on all axis, per each axis value,
  /// [showTitles] determines showing or hiding this side,
  /// texts are depend on the axis value, you can override [getTitles],
  /// it gives you an axis value (double value), and you should return a string.
  ///
  /// [reservedSize] determines how much space they needed,
  /// [getTextStyles] determines the text style of them,
  /// It gives you an axis value (double value), and you should return a TextStyle based on it,
  /// It works just like [getTitles]
  ///
  /// [textDirection] specifies the direction of showing text.
  /// it applies on all showing titles in this side.
  ///
  /// [margin] determines margin of texts from the border line,
  ///
  /// texts are showing with provided [interval],
  /// or you can let it be null to be calculated using [getEfficientInterval],
  /// also you can decide to show or not a specific title,
  /// using [checkToShowTitle].
  ///
  /// you can change rotation of drawing titles using [rotateAngle].
  SideTitles({
    bool? showTitles,
    GetTitleFunction? getTitles,
    double? reservedSize,
    GetTitleTextStyleFunction? getTextStyles,
    TextDirection? textDirection,
    double? margin,
    double? interval,
    double? rotateAngle,
    CheckToShowTitle? checkToShowTitle,
  })  : showTitles = showTitles ?? false,
        getTitles = getTitles ?? defaultGetTitle,
        reservedSize = reservedSize ?? 22,
        getTextStyles = getTextStyles ?? defaultGetTitleTextStyle,
        textDirection = textDirection ?? TextDirection.ltr,
        margin = margin ?? 6,
        interval = interval,
        rotateAngle = rotateAngle ?? 0.0,
        checkToShowTitle = checkToShowTitle ?? defaultCheckToShowTitle {
    if (interval == 0) {
      throw ArgumentError("SideTitles.interval couldn't be zero");
    }
  }

  /// Lerps a [SideTitles] based on [t] value, check [Tween.lerp].
  static SideTitles lerp(SideTitles a, SideTitles b, double t) {
    return SideTitles(
      showTitles: b.showTitles,
      getTitles: b.getTitles,
      reservedSize: lerpDouble(a.reservedSize, b.reservedSize, t),
      getTextStyles: b.getTextStyles,
      textDirection: b.textDirection,
      margin: lerpDouble(a.margin, b.margin, t),
      interval: lerpDouble(a.interval, b.interval, t),
      rotateAngle: lerpDouble(a.rotateAngle, b.rotateAngle, t),
      checkToShowTitle: b.checkToShowTitle,
    );
  }

  /// Copies current [SideTitles] to a new [SideTitles],
  /// and replaces provided values.
  SideTitles copyWith({
    bool? showTitles,
    GetTitleFunction? getTitles,
    double? reservedSize,
    GetTitleTextStyleFunction? getTextStyles,
    TextDirection? textDirection,
    double? margin,
    double? interval,
    double? rotateAngle,
    CheckToShowTitle? checkToShowTitle,
  }) {
    return SideTitles(
      showTitles: showTitles ?? this.showTitles,
      getTitles: getTitles ?? this.getTitles,
      reservedSize: reservedSize ?? this.reservedSize,
      getTextStyles: getTextStyles ?? this.getTextStyles,
      textDirection: textDirection ?? this.textDirection,
      margin: margin ?? this.margin,
      interval: interval ?? this.interval,
      rotateAngle: rotateAngle ?? this.rotateAngle,
      checkToShowTitle: checkToShowTitle ?? this.checkToShowTitle,
    );
  }

  /// Used for equality check, see [EquatableMixin].
  @override
  List<Object?> get props => [
    showTitles,
    getTitles,
    reservedSize,
    getTextStyles,
    margin,
    interval,
    rotateAngle,
    checkToShowTitle,
  ];
}


/// It gives you the axis value and gets a String value based on it.
typedef GetTitleFunction = String Function(double value);

/// It gives you the axis value and gets a TextStyle based on given value
///
/// If you return null, we try to provide an inherited TextStyle using theme.
/// (you can customize a specific title using this).
typedef GetTitleTextStyleFunction = TextStyle? Function(BuildContext context, double value);

/// Determines showing or hiding specified title.
typedef CheckToShowTitle = bool Function(
    double minValue, double maxValue, SideTitles sideTitles, double appliedInterval, double value);


/// The default [SideTitles.checkToShowTitle] function.
///
/// It determines showing or not showing specific title.
bool defaultCheckToShowTitle(
    double minValue, double maxValue, SideTitles sideTitles, double appliedInterval, double value) {
  if ((maxValue - minValue) % appliedInterval == 0) {
    return true;
  }
  return value != maxValue;
}

/// The default [SideTitles.getTextStyles] function.
///
/// returns a black TextStyle with 11 fontSize for all values.
TextStyle? defaultGetTitleTextStyle(BuildContext context, double value) => null;

/// The default [SideTitles.getTitles] function.
///
/// formats the axis number to a shorter string using [formatNumber].
String defaultGetTitle(double value) {
  return formatNumber(value);
}