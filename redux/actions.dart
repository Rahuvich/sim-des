import '../models/textile.dart';

class SimFinished {}

class OneClock {}

class DamagedTextiles {
  final List<Textile> textils;
  DamagedTextiles(this.textils);
}

class SeparatorToGroup1 {
  final List<Textile> textils;
  SeparatorToGroup1(this.textils);
}

class SeparatorToGroup2 {
  final List<Textile> textils;
  SeparatorToGroup2(this.textils);
}

class Rentadora1Loaded {
  final capacity;
  Rentadora1Loaded(this.capacity);
}

class Rentadora1Done {
  final capacity;
  Rentadora1Done(this.capacity);
}

class Rentadora2Loaded {
  final capacity;
  Rentadora2Loaded(this.capacity);
}

class Rentadora2Done {
  final capacity;
  Rentadora2Done(this.capacity);
}

class Secadora1Loaded {
  final capacity;
  Secadora1Loaded(this.capacity);
}

class Secadora1Done {
  final capacity;
  Secadora1Done(this.capacity);
}

class Secadora2Loaded {
  final capacity;
  Secadora2Loaded(this.capacity);
}

class Secadora2Done {
  final capacity;
  Secadora2Done(this.capacity);
}

class PlanxaLoaded {
  final capacity;
  PlanxaLoaded(this.capacity);
}

class PlanxaDone {
  final capacity;
  PlanxaDone(this.capacity);
}
