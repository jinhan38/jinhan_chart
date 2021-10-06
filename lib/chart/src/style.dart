// import 'package:flutter/material.dart';
// import 'package:jinhan_chart/chart/src/text_painter.dart';
//
// import 'line_chart_data.dart';
//
// class LineChartStyle {
//   final LegendStyle? legendStyle;
//   final List<DatasetStyle> datasetStyles;
//   final AxisStyle? topAxisStyle;
//   final AxisStyle? bottomAxisStyle;
//   final AxisStyle? leftAxisStyle;
//   final AxisStyle? rightAxisStyle;
//
//   /// the selection label style, which when specified enables a data label
//   /// when the chart is touched
//   final SelectionLabelStyle? selectionLabelStyle;
//
//   /// the duration of animations when rendering the chart
//   final Duration? animationDuration;
//
//   /// the style of the selection highlight
//   late final HighlightStyle? highlightStyle;
//
//   LineChartStyle(
//       {required this.legendStyle,
//         required this.datasetStyles,
//         this.topAxisStyle,
//         this.bottomAxisStyle,
//         this.leftAxisStyle,
//         this.rightAxisStyle,
//         this.highlightStyle,
//         this.selectionLabelStyle,
//         this.animationDuration = const Duration(seconds: 1)}) {
//     assert(topAxisStyle != null || bottomAxisStyle != null);
//     assert(leftAxisStyle != null || rightAxisStyle != null);
//   }
//
//   factory LineChartStyle.fromTheme(BuildContext context,
//   {List<Color>? datasetColors}){
//     final theme = Theme.of(context);
//     final textStyle = theme.textTheme.bodyText1 ?? theme.textTheme.bodyText2!;
//     final fontHeight = createTextPainter(textStyle, 'SAMPLE').height;
//     final lineColor = textStyle.color!.withOpacity(0.3);
//     final datasetSTyles =
//
//   }
// }
//
// const _defaultLineSize = 1.0;
// const _defaultFontSize = 12.0;
//
// class LegendStyle {
//   static final double defaultFontSize = _defaultFontSize;
//   final Color borderColor;
//   final TextStyle textStyle;
//   final EdgeInsets insets;
//   final borderSize = 1.0;
//
//   LegendStyle(
//       {required this.borderColor,
//       required this.textStyle,
//       required this.insets});
//
//   double get fontSize => textStyle.fontSize ?? defaultFontSize;
//
//   double get heightInsets => insets.top + insets.bottom + (borderSize * 2);
//
//   LegendStyle copyWith(
//       {Color? borderColor, TextStyle? textStyle, EdgeInsets? insets}) {
//     return LegendStyle(
//         borderColor: borderColor ?? this.borderColor,
//         textStyle: textStyle ?? this.textStyle,
//         insets: insets ?? this.insets);
//   }
//
//   @override
//   int get hashCode => hashValues(borderColor, textStyle, insets, borderSize);
//
//   @override
//   bool operator ==(Object other) =>
//       other is LegendStyle &&
//       other.borderSize == borderSize &&
//       other.borderColor == borderColor &&
//       other.insets == insets &&
//       other.textStyle == textStyle;
// }
//
// class DatasetStyle {
//   static const double defaultLineSize = _defaultLineSize;
//   final Color color;
//   final double fillOpacity;
//   final double lineSize;
//   final double cubicIntensity;
//
//   DatasetStyle(
//       {required this.color,
//       this.fillOpacity = 0.25,
//       this.lineSize = defaultLineSize,
//       this.cubicIntensity = 0.2});
//
//   DatasetStyle copyWith(
//       {Color? color,
//       double? fillOpacity,
//       double? lineSize,
//       double? cubicIntensity}) {
//     return DatasetStyle(
//         color: color ?? this.color,
//         fillOpacity: fillOpacity ?? this.fillOpacity,
//         lineSize: lineSize ?? this.lineSize,
//         cubicIntensity: cubicIntensity ?? this.cubicIntensity);
//   }
//
//   @override
//   int get hashCode => hashValues(color, lineSize, fillOpacity, cubicIntensity);
//
//   @override
//   bool operator ==(Object other) =>
//       other is DatasetStyle &&
//       other.color == color &&
//       other.lineSize == lineSize &&
//       other.fillOpacity == fillOpacity &&
//       other.cubicIntensity == cubicIntensity;
// }
//
// typedef LabelFunction = String Function(DataPoint);
//
// class AxisStyle{
//
//   static final double defaultFontSize = _defaultFontSize;
//
//   /// the maximum number of labels to display
//   final int maxLabels;
//
//   /// if specified, the number of labels to display
//   final int? labelCount;
//
//   /// when true, the first label is not shown
//   final bool skipFirstLabel;
//
//   /// when true, the last label is not shown
//   final bool skipLastLabel;
//
//   /// when true, labels are shown exactly on datapoints instead of
//   /// at any interval.
//   final bool labelOnDatapoints;
//
//   /// when specified, labels must be placed on values that are multiples
//   /// of the specified value. For example, [labelIncrementMultiples] = 1 would
//   /// make labels appear on whole values only.
//   final int? labelIncrementMultiples;
//
//   /// the function that provides a text label from a data point value
//   final LabelFunction labelProvider;
//
//   /// the style to use when rendering labels
//   final TextStyle textStyle;
//
//   /// when false, labels are not shown
//   final bool drawLabels;
//
//   /// insets to apply to the axis
//   final EdgeInsets labelInsets;
//
//   /// the axis line color
//   final Color lineColor;
//
//   /// the width of the axis line
//   final double lineSize;
//
//   /// if specified, constrains the chart so that
//   /// the chart displays with this value as the lower bound.
//   final double? absoluteMin;
//
//   /// if specified, constrains the minimum chart area value
//   /// when the [minimumRange] is applied.
//   final double? clampedMin;
//
//   /// if specified, constrains the chart so that
//   /// the chart displays with this value as the upper bound.
//   final double? absoluteMax;
//
//   /// the margin to apply above the maximum value on the chart,
//   /// in data point units.
//   final double? marginAbove;
//
//   /// the margin to apply below the minimum value on the chart,
//   /// in data point units.
//   final double? marginBelow;
//
//
//   /// the minimum range that values occupy on the chart regardless
//   /// of values in the series.
//   final double? minimumRange;
//
//
//   AxisStyle(
//       {required this.textStyle,
//         required this.labelInsets,
//         required this.labelProvider,
//         required this.lineColor,
//         this.lineSize = _defaultLineSize,
//         this.drawLabels = true,
//         this.maxLabels = 20,
//         this.labelCount,
//         this.skipFirstLabel = false,
//         this.skipLastLabel = false,
//         this.labelOnDatapoints = false,
//         this.labelIncrementMultiples,
//         this.absoluteMin,
//         this.clampedMin,
//         this.absoluteMax,
//         this.marginAbove,
//         this.marginBelow,
//         this.minimumRange});
//
//   double get fontSize => textStyle.fontSize ?? defaultFontSize;
//
//   @override
//   int get hashCode => hashValues(
//       maxLabels,
//       labelCount,
//       skipFirstLabel,
//       skipLastLabel,
//       labelOnDatapoints,
//       labelIncrementMultiples,
//       labelProvider,
//       textStyle,
//       drawLabels,
//       labelInsets,
//       lineColor,
//       lineSize,
//       absoluteMin,
//       clampedMin,
//       absoluteMax,
//       marginAbove,
//       marginBelow,
//       minimumRange);
//
//
//   @override
//   bool operator ==(Object other) =>
//       other is AxisStyle &&
//           other.maxLabels == maxLabels &&
//           other.labelCount == labelCount &&
//           other.skipFirstLabel == skipFirstLabel &&
//           other.skipLastLabel == skipLastLabel &&
//           other.labelOnDatapoints == labelOnDatapoints &&
//           other.labelIncrementMultiples == labelIncrementMultiples &&
//           other.labelProvider == labelProvider &&
//           other.textStyle == textStyle &&
//           other.drawLabels == drawLabels &&
//           other.labelInsets == labelInsets &&
//           other.lineColor == lineColor &&
//           other.lineSize == lineSize &&
//           other.absoluteMax == absoluteMax &&
//           other.absoluteMin == absoluteMin &&
//           other.clampedMin == clampedMin &&
//           other.marginAbove == marginAbove &&
//           other.marginBelow == marginBelow &&
//           other.minimumRange == minimumRange &&
//           other.textStyle == textStyle;
//
//   AxisStyle copyWith(
//       {int? maxLabels,
//         int? labelCount,
//         bool? skipFirstLabel,
//         bool? skipLastLabel,
//         bool? labelOnDatapoints,
//         int? labelIncrementMultiples,
//         LabelFunction? labelProvider,
//         TextStyle? textStyle,
//         bool? drawLabels,
//         EdgeInsets? labelInsets,
//         Color? lineColor,
//         double? lineSize,
//         double? absoluteMin,
//         double? clampedMin,
//         double? absoluteMax,
//         double? marginAbove,
//         double? marginBelow,
//         double? minimumRange}) {
//     return AxisStyle(
//         textStyle: textStyle ?? this.textStyle,
//         labelInsets: labelInsets ?? this.labelInsets,
//         skipFirstLabel: skipFirstLabel ?? this.skipFirstLabel,
//         skipLastLabel: skipLastLabel ?? this.skipLastLabel,
//         labelOnDatapoints: labelOnDatapoints ?? this.labelOnDatapoints,
//         labelIncrementMultiples:
//         labelIncrementMultiples ?? this.labelIncrementMultiples,
//         labelProvider: labelProvider ?? this.labelProvider,
//         lineColor: lineColor ?? this.lineColor,
//         lineSize: lineSize ?? this.lineSize,
//         drawLabels: drawLabels ?? this.drawLabels,
//         maxLabels: maxLabels ?? this.maxLabels,
//         labelCount: labelCount ?? this.labelCount,
//         absoluteMin: absoluteMin ?? this.absoluteMin,
//         clampedMin: clampedMin ?? this.clampedMin,
//         absoluteMax: absoluteMax ?? this.absoluteMax,
//         marginAbove: marginAbove ?? this.marginAbove,
//         marginBelow: marginBelow ?? this.marginBelow,
//         minimumRange: minimumRange ?? this.minimumRange);
//   }
// }
//
// /// a style for rendering a selection label
// class SelectionLabelStyle{
//
//   /// the function that provides a text label from a data point value
//   /// for data points that have [YAxisDependency.LEFT]
//   final LabelFunction? leftYAxisLabelProvider;
//
//   /// the function that provides a text label from a data point value
//   /// for data points that have [YAxisDependency.RIGHT]
//   final LabelFunction? rightYAxisLabelProvider;
//
//   /// the function that provides a text label from a data point value
//   /// for the x axis
//   final LabelFunction? xAxisLabelProvider;
//
//   /// the text style of the selection label
//   final TextStyle textStyle;
//
//   /// the border line color
//   final Color borderColor;
//
//   /// the width of the border line
//   final borderSize = 1.0;
//
//   SelectionLabelStyle(
//       {this.leftYAxisLabelProvider,
//         this.rightYAxisLabelProvider,
//         this.xAxisLabelProvider,
//         required this.textStyle,
//         required this.borderColor});
//
//   SelectionLabelStyle copyWith(
//       {LabelFunction? leftYAxisLabelProvider,
//         LabelFunction? rightYAxisLabelProvider,
//         LabelFunction? xAxisLabelProvider,
//         TextStyle? textStyle,
//         Color? borderColor}) {
//     return SelectionLabelStyle(
//       leftYAxisLabelProvider:
//       leftYAxisLabelProvider ?? this.leftYAxisLabelProvider,
//       rightYAxisLabelProvider:
//       rightYAxisLabelProvider ?? this.rightYAxisLabelProvider,
//       xAxisLabelProvider: xAxisLabelProvider ?? this.xAxisLabelProvider,
//       textStyle: textStyle ?? this.textStyle,
//       borderColor: borderColor ?? this.borderColor,
//     );
//   }
//
//   /// provides a copy of the style removing the specified elements
//   SelectionLabelStyle copyRemoving(
//       {leftAxisLabel = false, rightAxisLabel = false, xAxisLabel = false}) {
//     return SelectionLabelStyle(
//         leftYAxisLabelProvider: leftAxisLabel ? null : leftYAxisLabelProvider,
//         rightYAxisLabelProvider:
//         rightAxisLabel ? null : rightYAxisLabelProvider,
//         xAxisLabelProvider: xAxisLabel ? null : xAxisLabelProvider,
//         textStyle: textStyle,
//         borderColor: borderColor);
//   }
//
//   @override
//   int get hashCode => hashValues(borderColor, borderSize, xAxisLabelProvider,
//       rightYAxisLabelProvider, leftYAxisLabelProvider);
//
//   @override
//   bool operator ==(Object other) =>
//       other is SelectionLabelStyle &&
//           other.borderSize == borderSize &&
//           other.borderColor == borderColor &&
//           other.xAxisLabelProvider == xAxisLabelProvider &&
//           other.rightYAxisLabelProvider == rightYAxisLabelProvider &&
//           other.leftYAxisLabelProvider == leftYAxisLabelProvider;
//
// }
//
// class HighlightStyle{
//
//   final Color color;
//   final double lineSize;
//   final bool vertical;
//   final bool horizontal;
//
//   HighlightStyle(
//       {required this.color,
//         this.lineSize = _defaultLineSize,
//         this.vertical = true,
//         this.horizontal = true});
//
//   HighlightStyle copyWith(
//       {Color? color, double? lineSize, bool? vertical, bool? horizontal}) {
//     return HighlightStyle(
//         color: color ?? this.color,
//         lineSize: lineSize ?? this.lineSize,
//         vertical: vertical ?? this.vertical,
//         horizontal: horizontal ?? this.horizontal);
//   }
//
//   @override
//   int get hashCode => hashValues(color, lineSize, vertical, horizontal);
//
//   @override
//   bool operator ==(Object other) =>
//       other is HighlightStyle &&
//           other.color == color &&
//           other.lineSize == lineSize &&
//           other.vertical == vertical &&
//           other.horizontal == horizontal;
// }
