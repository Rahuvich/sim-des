import 'dart:async';
import 'dart:math';
import 'extensions.dart';
import 'textile.dart';
import 'dart:io';
import 'dart:convert';
import '../globals.dart';

class Generator {
  static int seed;
  static int _next_arrival = Random(seed).nextInt(6*60 + 1) + 3*60; // Uniform distribution (3 - 6 h)
  static int _clock_last_arrival;

  static List<Textile> generateTextile(int clock) {
    if (_clock_last_arrival == null ||
        _clock_last_arrival + _next_arrival < clock) {
      int count = Random(seed).nextInt(101) + 300; // Uniform distribution (300 - 400 pieces)
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