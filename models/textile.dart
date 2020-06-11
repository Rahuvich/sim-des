import '../globals.dart';

class Textile {
  Textile({this.tipus, this.id}) {
    this.name = type[this.tipus];
    this.damaged = false;
  }

  final String id;
  String name;
  final int tipus;
  bool damaged;

  @override
  bool operator ==(textil) {
    return (textil is Textile) && textil.id == this.id;
  }
}

const Map<int, String> type = const {
  0: "Tovallola",
  1: "Cobrellit",
  2: "Manta",
  3: "Funda de coixí",
  4: "Llençol"
};
