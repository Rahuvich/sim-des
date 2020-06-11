import '../globals.dart';

class Textile {
  //Textile({this.name, this.tipus, this.damaged}) : status = TextileStatus.DIRTY;
  
  Textile({this.tipus}) {
    this.name = textileTypes[this.tipus];
    this.damaged = false;
    this.status = TextileStatus.DIRTY;
  }

  String name;
  final int tipus;
  bool damaged;
  TextileStatus status;
}

enum TextileStatus { DIRTY, WASHED, DRIED, IRONED }

