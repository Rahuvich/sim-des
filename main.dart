import 'models/entity.dart';

void main() {
  // Initialize
  print("ESTAT: Iniciant màquinaria");
  int clock = 0;
  List<Entity> textils = List();

  // Running
  print("ESTAT: Running");
  while (clock < 800) {
    ++clock;
  }

  // To finish
  print("ESTAT: S'ha acabat la simulació");
}
