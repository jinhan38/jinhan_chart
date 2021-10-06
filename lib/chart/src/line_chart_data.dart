import 'dart:math';

import 'package:flutter/material.dart';

enum YAxisDependency { LEFT, RIGHT }

class Dataset {
  final String label;
  final String shortLabel;
  final YAxisDependency axisDependency;
  final List<DataPoint> dataPoints;


  Dataset(
      {required this.label,
        String? shortLabel,
        this.axisDependency = YAxisDependency.LEFT,
        required this.dataPoints})
      : this.shortLabel = shortLabel ?? label;

  double get maxY =>
      dataPoints.isEmpty ? 0 : dataPoints.map((e) => e.y).reduce(max);

  double get minY =>
      dataPoints.isEmpty ? 0 : dataPoints.map((e) => e.y).reduce(min);

  double get maxX =>
      dataPoints.isEmpty ? 0 : dataPoints.map((e) => e.x).reduce(max);

  double get minX =>
      dataPoints.isEmpty ? 0 : dataPoints.map((e) => e.x).reduce(min);

  @override
  bool operator ==(Object other) =>
      other is Dataset &&
          other.label == label &&
          other.shortLabel == shortLabel &&
          other.dataPoints == dataPoints;

  @override
  int get hashCode => hashValues(label, shortLabel, dataPoints);

  @override
  String toString() =>
      'Dataset(label=$label,shortLabel=$shortLabel,dataPoints=[${dataPoints
          .length}])';


}

class DataPoint {
  final double x;
  final double y;
  final Object? model;

  DataPoint({required this.x, required this.y, this.model});

  Offset toOffset() => Offset(x, y);

  @override
  int get hashCode => hashValues(x, y, model);

  @override
  bool operator ==(Object other) =>
      other is DataPoint &&
          other.x == x &&
          other.y == y &&
          other.model == model;

  @override
  String toString() => 'DataPoint(x=$x,y=$y,model=$model)';

}

class QualifiedDataPoint {
  final Dataset dataset;
  final DataPoint dataPoint;

  QualifiedDataPoint(this.dataset, this.dataPoint);


  @override
  int get hashCode => dataPoint.hashCode;

  @override
  bool operator ==(Object other) =>
      other is QualifiedDataPoint &&
          other.dataPoint == dataPoint &&
          other.dataset == dataset;

  @override
  String toString() =>
      'QualifiedDataPoint(dataset=$dataset,dataPoint=$dataPoint)';
}