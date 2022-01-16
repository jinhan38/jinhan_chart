import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jinhan_chart/custom/util/pd_lerp.dart';

class PdRangeAnnotations with EquatableMixin {
  final List<HorizontalRangeAnnotation> horizontalRangeAnnotations;
  final List<VerticalRangeAnnotation> verticalRangeAnnotations;

  PdRangeAnnotations({
    List<HorizontalRangeAnnotation>? horizontalRangeAnnotations,
    List<VerticalRangeAnnotation>? verticalRangeAnnotations,
  })  : horizontalRangeAnnotations = horizontalRangeAnnotations ?? const [],
        verticalRangeAnnotations = verticalRangeAnnotations ?? const [];

  static PdRangeAnnotations lerp(
      PdRangeAnnotations a, PdRangeAnnotations b, double t) {
    return PdRangeAnnotations(
      horizontalRangeAnnotations: lerpHorizontalRangeAnnotationList(
          a.horizontalRangeAnnotations, b.horizontalRangeAnnotations, t),
      verticalRangeAnnotations: lerpVerticalRangeAnnotationList(
          a.verticalRangeAnnotations, b.verticalRangeAnnotations, t),
    );
  }

  PdRangeAnnotations copyWith({
    List<HorizontalRangeAnnotation>? horizontalRangeAnnotations,
    List<VerticalRangeAnnotation>? verticalRangeAnnotations,
  }) {
    return PdRangeAnnotations(
      horizontalRangeAnnotations:
      horizontalRangeAnnotations ?? this.horizontalRangeAnnotations,
      verticalRangeAnnotations:
      verticalRangeAnnotations ?? this.verticalRangeAnnotations,
    );
  }

  @override
  List<Object?> get props => [
    horizontalRangeAnnotations,
    verticalRangeAnnotations,
  ];


}

class HorizontalRangeAnnotation with EquatableMixin {
  /// Determines starting point in vertical (y) axis.
  final double y1;

  /// Determines ending point in vertical (y) axis.
  final double y2;

  /// Fills the area with this color.
  final Color color;

  HorizontalRangeAnnotation({
    required double y1,
    required double y2,
    Color? color,
  })  : y1 = y1,
        y2 = y2,
        color = color ?? Colors.white;

  static HorizontalRangeAnnotation lerp(
      HorizontalRangeAnnotation a, HorizontalRangeAnnotation b, double t) {
    return HorizontalRangeAnnotation(
      y1: lerpDouble(a.y1, b.y1, t)!,
      y2: lerpDouble(a.y2, b.y2, t)!,
      color: Color.lerp(a.color, b.color, t),
    );
  }

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

  @override
  List<Object?> get props => [
        y1,
        y2,
        color,
      ];
}

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
