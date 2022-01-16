import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jinhan_chart/custom/touch/pd_touch_data.dart';

abstract class BaseChartData with EquatableMixin {
  PdBorderData borderData;

  PdTouchData touchData;

  BaseChartData({
    PdBorderData? borderData,
    required PdTouchData touchData,
  })  : borderData = borderData ?? PdBorderData(),
        touchData = touchData;

  BaseChartData lerp(BaseChartData a, BaseChartData b, double t);

  /// Used for equality check, see [EquatableMixin].
  @override
  List<Object?> get props => [
        borderData,
        touchData,
      ];
}

class PdBorderData with EquatableMixin {
  final bool show;
  Border border;

  PdBorderData({
    bool? show,
    Border? border,
  })  : show = show ?? true,
        border = border ??
            Border.all(
                color: Colors.black, width: 1.0, style: BorderStyle.solid);

  static PdBorderData lerp(PdBorderData a, PdBorderData b, double t) {
    return PdBorderData(
        show: b.show, border: Border.lerp(a.border, b.border, t));
  }

  @override
  List<Object> get props => [
        show,
        border,
      ];
}

class PdClipData with EquatableMixin {
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  PdClipData({
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  });

  PdClipData.all() : this(top: true, bottom: true, left: true, right: true);

  PdClipData.vertical()
      : this(top: true, bottom: true, left: false, right: false);

  PdClipData.horizontal()
      : this(top: false, bottom: false, left: true, right: true);

  PdClipData.none()
      : this(top: false, bottom: false, left: false, right: false);

  bool get any => top || bottom || left || right;

  PdClipData copyWith({
    bool? top,
    bool? bottom,
    bool? left,
    bool? right,
  }) {
    return PdClipData(
      top: top ?? this.top,
      bottom: bottom ?? this.bottom,
      left: left ?? this.left,
      right: right ?? this.right,
    );
  }

  @override
  List<Object?> get props => [
        top,
        bottom,
        left,
        right,
      ];
}
