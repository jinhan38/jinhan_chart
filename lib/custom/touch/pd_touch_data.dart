import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jinhan_chart/custom/touch/base_touch.dart';
import 'package:jinhan_chart/custom/touch/pd_touch_event.dart';

abstract class PdTouchData<R extends BaseTouchEvent> with EquatableMixin {
  final bool enabled;

  final BaseTouchCallback<R>? touchCallback;
  final MouseCursorResolver<R>? mouseCursorResolver;

  PdTouchData(
    bool enabled,
    BaseTouchCallback<R>? touchCallback,
    MouseCursorResolver<R>? mouseCursorResolver,
  )   : enabled = enabled,
        touchCallback = touchCallback,
        mouseCursorResolver = mouseCursorResolver;
}

typedef BaseTouchCallback<R extends BaseTouchEvent> = void Function(
    PdTouchEvent);

typedef MouseCursorResolver<R extends BaseTouchEvent> = MouseCursor Function(
    PdTouchEvent, R?);
