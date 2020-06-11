import 'models/textile.dart';
import 'models/generator.dart';


void main() {
  // Initialize
  print("ESTAT: Iniciant màquinaria");
  int clock = 0;
  Generator generator = Generator();
  
  // Running
  print("ESTAT: Running");

  List<Textile> initialQueue = generator.generateTextile(clock);

  while (clock < (8 * 60)) {
    initialQueue.addAll(generator.generateTextile(clock));

    ++clock;
  }

  // To finish
  print("S'ha acabat la simulació amb ${initialQueue.length} peces");

  //for(Textile textile in initialQueue) print("PEÇA: ${textile.name}");

  print("ESTAT: S'ha acabat la simulació");
}



