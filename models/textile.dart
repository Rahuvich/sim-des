import '../globals.dart';

class Textile {
  Textile({this.tipus, this.id, this.damaged}) {
    this.name = textileTypes[this.tipus];
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
