




import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class PdDotPainter with EquatableMixin{
  void draw(Canvas canvas, PdSpot spot, Offset offsetInCanvas);
  Size getSize(PdSpot spot);
}

class PdSpot with EquatableMixin{
  final double x;
  final double y;

  PdSpot(double x, double y)
      : x = x,
        y = y;
  PdSpot copyWith({
    double? x,
    double? y,
  }) {
    return PdSpot(
      x ?? this.x,
      y ?? this.y,
    );
  }

  @override
  String toString() {
    return '(' + x.toString() + ', ' + y.toString() + ')';
  }
  static PdSpot nullSpot = PdSpot(double.nan, double.nan);
  bool isNull() => this == nullSpot;

  bool isNotNull() => !isNull();
  @override
  List<Object?> get props => [
    x,
    y,
  ];
  static PdSpot lerp(PdSpot a, PdSpot b, double t) {
    if (a == PdSpot.nullSpot) {
      return b;
    }

    if (b == PdSpot.nullSpot) {
      return a;
    }

    return PdSpot(
      lerpDouble(a.x, b.x, t)!,
      lerpDouble(a.y, b.y, t)!,
    );
  }
}