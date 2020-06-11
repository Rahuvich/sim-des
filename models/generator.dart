import 'dart:math';

import 'package:normal/normal.dart';
import 'package:uuid/uuid.dart';
import 'extensions.dart';
import 'package:uuid/uuid.dart';
import 'textile.dart';

class Generator {
  static int seed;
  static int _next_arrival =
      Normal.generate(1, mean: (4 * 60), variance: 30).first.round();
  static int _clock_last_arrival;

  static List<Textile> generateTextile(int clock) {
    if (_clock_last_arrival == null ||
        _clock_last_arrival + _next_arrival < clock) {
      int count = Normal.generate(1, mean: 400, variance: 50).first.round();
      print(
          '${clock.toTimeString()} CLK: ESDEVENIMENT: Ha arribat un camió amb $count peces!');
      _clock_last_arrival = clock;

      Random random = new Random();
      return List<Textile>.generate(count,
          (index) => new Textile(tipus: random.nextInt(5), id: Uuid().v4()));
    }
    return List<Textile>();
  }
}
