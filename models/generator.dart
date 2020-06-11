import 'dart:async';
import 'dart:math';
import 'package:normal/normal.dart';
import 'extensions.dart';
import 'textile.dart';
import 'dart:io';
import 'dart:convert';
import '../globals.dart';

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
      return List<Textile>.generate(
          count, (index) => new Textile(tipus: random.nextInt(5)));
    }
    return List<Textile>();
  }
}


readInputData() {
  final File file = File("files/InputData.csv");
  Stream<List> inputStream = file.openRead();

  inputStream
      .transform(utf8.decoder)       // Decode bytes to UTF-8.
      .transform(new LineSplitter()) // Convert stream to individual lines.
      .listen((String line) {        // Process results.

        List row = line.split(','); // split by comma

        String name = row[0];
        String type = row[1];

        textileTypes[int.parse(type)] = name;

        print("${textileTypes[int.parse(type)]}");
    },
    onError: (e) { print("Error on reading InputData.csv"); });
}