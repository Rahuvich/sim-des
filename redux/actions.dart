import '../models/textile.dart';

class SimFinished {}

class OneClock {}

class SeparatorToGroup1 {
  final List<Textile> textils;
  SeparatorToGroup1(this.textils);
}

class SeparatorToGroup2 {
  final List<Textile> textils;
  SeparatorToGroup2(this.textils);
}

class RentadoraLoaded {
  final capacity;
  RentadoraLoaded(this.capacity);
}

class RentadoraDone {
  final capacity;
  RentadoraDone(this.capacity);
}

class SecadoraLoaded {
  final capacity;
  SecadoraLoaded(this.capacity);
}

class SecadoraDone {
  final capacity;
  SecadoraDone(this.capacity);
}
