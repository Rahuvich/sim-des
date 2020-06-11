import 'textile.dart';

class Processador {
  int clock_last_loaded;
  int duracio;
  final int capacitat;

  Processador({this.capacitat, this.duracio});

  processa(int clock, Function onLoaded, Function onDone) {
    if (clock_last_loaded == null || (clock_last_loaded + duracio) < clock) {
      clock_last_loaded = clock;
      onLoaded();
    } else if (clock_last_loaded + duracio == clock) {
      onDone();
    }
  }
}
