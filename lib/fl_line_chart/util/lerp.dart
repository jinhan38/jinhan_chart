import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jinhan_chart/fl_line_chart/data/axis_chart_data.dart';
import 'package:jinhan_chart/fl_line_chart/data/line_chart_data.dart';

/// Lerps [int] list based on [t] value, check [Tween.lerp].
int lerpInt(int a, int b, double t) => (a + (b - a) * t).round();

List<T>? _lerpList<T>(List<T>? a, List<T>? b, double t,
    {required T Function(T, T, double) lerp}) {
  if (a != null && b != null && a.length == b.length) {
    return List.generate(a.length, (i) {
      return lerp(a[i], b[i], t);
    });
  } else if (a != null && b != null) {
    return List.generate(b.length, (i) {
      return lerp(i >= a.length ? b[i] : a[i], b[i], t);
    });
  } else {
    return b;
  }
}

List<int>? lerpIntList(List<int>? a, List<int>? b, double t) =>
    _lerpList(a, b, t, lerp: lerpInt);

/// Lerps [HorizontalRangeAnnotation] list based on [t] value, check [Tween.lerp].
List<HorizontalRangeAnnotation>? lerpHorizontalRangeAnnotationList(
        List<HorizontalRangeAnnotation>? a,
        List<HorizontalRangeAnnotation>? b,
        double t) =>
    _lerpList(a, b, t, lerp: HorizontalRangeAnnotation.lerp);

/// Lerps [VerticalRangeAnnotation] list based on [t] value, check [Tween.lerp].
List<VerticalRangeAnnotation>? lerpVerticalRangeAnnotationList(
        List<VerticalRangeAnnotation>? a,
        List<VerticalRangeAnnotation>? b,
        double t) =>
    _lerpList(a, b, t, lerp: VerticalRangeAnnotation.lerp);

/// Lerps [LineChartBarData] list based on [t] value, check [Tween.lerp].
List<LineChartBarData>? lerpLineChartBarDataList(
        List<LineChartBarData>? a, List<LineChartBarData>? b, double t) =>
    _lerpList(a, b, t, lerp: LineChartBarData.lerp);

/// Lerps [BetweenBarsData] list based on [t] value, check [Tween.lerp].
List<BetweenBarsData>? lerpBetweenBarsDataList(
        List<BetweenBarsData>? a, List<BetweenBarsData>? b, double t) =>
    _lerpList(a, b, t, lerp: BetweenBarsData.lerp);

/// Lerps [Color] list based on [t] value, check [Tween.lerp].
List<Color>? lerpColorList(List<Color>? a, List<Color>? b, double t) =>
    _lerpList(a, b, t, lerp: lerpColor);

/// Lerps [Color] based on [t] value, check [Color.lerp].
Color lerpColor(Color a, Color b, double t) => Color.lerp(a, b, t)!;


/// Lerps [double] list based on [t] value, check [Tween.lerp].
List<double>? lerpDoubleList(List<double>? a, List<double>? b, double t) =>
    _lerpList(a, b, t, lerp: _lerpNonNullDouble);

double _lerpNonNullDouble(double a, double b, double t) => lerpDouble(a, b, t)!;

/// Lerps [FlSpot] list based on [t] value, check [Tween.lerp].
List<FlSpot>? lerpFlSpotList(List<FlSpot>? a, List<FlSpot>? b, double t) =>
    _lerpList(a, b, t, lerp: FlSpot.lerp);


/// Lerps [HorizontalLine] list based on [t] value, check [Tween.lerp].
List<HorizontalLine>? lerpHorizontalLineList(
    List<HorizontalLine>? a, List<HorizontalLine>? b, double t) =>
    _lerpList(a, b, t, lerp: HorizontalLine.lerp);

/// Lerps [VerticalLine] list based on [t] value, check [Tween.lerp].
List<VerticalLine>? lerpVerticalLineList(List<VerticalLine>? a, List<VerticalLine>? b, double t) =>
    _lerpList(a, b, t, lerp: VerticalLine.lerp);

