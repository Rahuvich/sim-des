import 'dart:async';
import 'dart:math';

import 'extensions.dart';
import 'package:uuid/uuid.dart';
import 'textile.dart';
import 'dart:io';
import 'dart:convert';
import '../globals.dart';

class Generator {
  static int seed;
  static int _next_arrival = Random(seed).nextInt(6 * 60 + 1) +
      3 * 60; // Uniform distribution (3 - 6 h)
  static int _clock_last_arrival;

  static List<Textile> generateTextile(int clock) {
    if (_clock_last_arrival == null ||
        _clock_last_arrival + _next_arrival < clock) {
      int count = Random(seed).nextInt(101) +
          300; // Uniform distribution (300 - 400 pieces)
      print(
          '${clock.toTimeString()} CLK: ESDEVENIMENT: Ha arribat un camió amb $count peces!');
      _clock_last_arrival = clock;

      Random random = new Random(seed);
      return List<Textile>.generate(
          count,
          (index) => new Textile(
              tipus: random.nextInt(textileTypes.length), id: Uuid().v4()));
    }
    return List<Textile>();
  }
}
