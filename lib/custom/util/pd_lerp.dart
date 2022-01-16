import 'package:jinhan_chart/custom/annotation/pd_range_annotation.dart';

int lerpInt(int a, int b, double t) => (a + (b - a) * t).round();

List<int>? lerpIntList(List<int>? a, List<int>? b, double t) =>
    _lerpList(a, b, t, lerp: lerpInt);

List<T>? _lerpList<T>(List<T>? a, List<T>? b, double t,
    {required T Function(T, T, double) lerp}) {
  if (a != null && b != null && a.length == b.length) {
    return List.generate(a.length, (index) {
      return lerp(a[index], b[index], t);
    });
  } else if (a != null && b != null) {
    return List.generate(b.length, (index) {
      return lerp(index >= a.length ? b[index] : a[index], b[index], t);
    });
  } else {
    return b;
  }
}

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