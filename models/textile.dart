import '../globals.dart';

class Textile {
  //Textile({this.name, this.tipus, this.damaged}) : status = TextileStatus.DIRTY;

  Textile({this.tipus, this.id}) {
    this.name = type[this.tipus];
    this.damaged = false;
    this.status = TextileStatus.DIRTY;
  }

  int id;
  String name;
  final int tipus;
  bool damaged;
  TextileStatus status;
}

enum TextileStatus { DIRTY, WASHED, DRIED, IRONED }
const Map<int, String> type = const {
  0: "Tovallola",
  1: "Cobrellit",
  2: "Manta",
  3: "Funda de coixí",
  4: "Llençol"
};
