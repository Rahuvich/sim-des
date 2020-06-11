import 'textile.dart';

class Processador {
  int clock_last_loaded;
  bool running;
  int duracio;
  final int capacitat;

  Processador({this.capacitat, this.duracio}) : running = false;

  processa(
      int clock, bool hayTextilEsperando, Function onLoaded, Function onDone) {
    if ((clock_last_loaded == null || (clock_last_loaded + duracio) < clock) &&
        hayTextilEsperando) {
      running = true;
      clock_last_loaded = clock;
      onLoaded();
    } else if (running && clock_last_loaded + duracio == clock) {
      onDone();
    }
  }
}
