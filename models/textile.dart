class Textile {
  Textile({this.name, this.tipus, this.damaged}) : status = TextileStatus.DIRTY;
  final String name;
  final int tipus;
  final bool damaged;
  TextileStatus status;
}

enum TextileStatus { DIRTY, WASHED, DRIED, IRONED }
