import 'package:normal/normal.dart';

import 'textile.dart';

class Generator {
  int seed;
  int _next_arrival;
  int _clock_last_arrival;

  Generator({this.seed})
      : _next_arrival =
            Normal.generate(1, mean: (4 * 60), variance: 30).first.round();

  List<Textile> generateTextile(int clock) {
    if (_clock_last_arrival == null ||
        _clock_last_arrival + _next_arrival < clock) {
      int count = Normal.generate(1, mean: 400, variance: 50).first.round();
      print('$clock CLK: ESDEVENIMENT: Ha arribat un camió amb $count peces!');
      _clock_last_arrival = clock;
      return List<Textile>.generate(count,
          (index) => new Textile(name: "Tovallola", tipus: 2, damaged: false));
    }
    return List<Textile>();
  }
}
