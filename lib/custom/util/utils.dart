
import 'dart:math';

double getEfficientInterval(double axisViewSize, double diffInYAxis,
    {double pixelPerInterval = 40}) {
  final allowedCount = axisViewSize ~/ pixelPerInterval;
  final accurateInterval = diffInYAxis / allowedCount;
  return    0;
}

int _roundInterval(double input) {
  var count = 0;
  if (input >= 10) count ++;

  while(input ~/100 != 0){
    input /= 10;
    count++;
  }

  final scaled = input >= 100 ? input.round() /10 : input;


  if (scaled >= 2.6) {
    return 5 * pow(10, count).toInt();
  } else if (scaled >= 1.6) {
    return 2 * pow(10, count).toInt();
  } else {
    return pow(10, count).toInt();
  }

}