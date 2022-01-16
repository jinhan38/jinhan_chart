import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

abstract class PdTouchEvent {
  Offset? get localPosition => null;

  bool get isInterestedForInteractions {
    final isDesktopOrWeb =
        kIsWeb || Platform.isLinux || Platform.isMacOS || Platform.isWindows;
    if (isDesktopOrWeb && this is PdTapUpEvent) {
      return true;
    }
    return this is! PdPanEndEvent &&
        this is! PdPanCancelEvent &&
        this is! PdPointerExitEvent &&
        this is! PdLongPressEnd &&
        this is! PdTapUpEvent &&
        this is! PdTapCancelEvent;
  }
}

///화면을 터치했을 때 호출
class PdPanDownEvent extends PdTouchEvent {
  final DragDownDetails details;

  PdPanDownEvent(this.details);

  @override
  Offset get localPosition => details.localPosition;
}

///화면을 터치하고 드래그를 시작할 때 호출
class PdPanStartEvent extends PdTouchEvent {
  final DragStartDetails details;

  PdPanStartEvent(this.details);

  @override
  Offset get localPosition => details.localPosition;
}

///화면을 드래그하는 도중에 호출
class PdPanUpdateEvent extends PdTouchEvent {
  final DragUpdateDetails details;

  PdPanUpdateEvent(this.details);

  @override
  Offset get localPosition => details.localPosition;
}

///드래그하다가 취소된 경우
class PdPanCancelEvent extends PdTouchEvent {}

///움직임이 멈췄을 때
class PdPanEndEvent extends PdTouchEvent {
  final DragEndDetails details;

  PdPanEndEvent(this.details);
}

class PdTapDownEvent extends PdTouchEvent {
  final TapDownDetails details;

  PdTapDownEvent(this.details);

  @override
  Offset get localPosition => details.localPosition;
}

class PdTapCancelEvent extends PdTouchEvent {}

class PdTapUpEvent extends PdTouchEvent {
  final TapUpDetails details;

  PdTapUpEvent(this.details);

  @override
  Offset get localPosition => details.localPosition;
}

class PdLongPressStart extends PdTouchEvent {
  final LongPressStartDetails details;

  PdLongPressStart(this.details);

  @override
  Offset get localPosition => details.localPosition;
}

class PdLongPressMoveUpdate extends PdTouchEvent {
  final LongPressMoveUpdateDetails details;

  PdLongPressMoveUpdate(this.details);

  @override
  Offset get localPosition => details.localPosition;
}

class PdLongPressEnd extends PdTouchEvent {
  final LongPressEndDetails details;

  PdLongPressEnd(this.details);

  @override
  Offset get localPosition => details.localPosition;
}

class PdPointerEnterEvent extends PdTouchEvent {
  final PointerEnterEvent event;

  PdPointerEnterEvent(this.event);

  @override
  Offset get localPosition => event.localPosition;
}

class PdPointerHoverEvent extends PdTouchEvent {
  final PointerHoverEvent event;

  PdPointerHoverEvent(this.event);

  @override
  Offset get localPosition => event.localPosition;
}

class PdPointerExitEvent extends PdTouchEvent {
  final PointerExitEvent event;

  PdPointerExitEvent(this.event);

  @override
  Offset get localPosition => event.localPosition;
}

Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  final length = colors.length;
  if (stops.length != length) {
    stops = List.generate(length, (index) => (index + 1) / length);
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }

  return colors.last;
}
