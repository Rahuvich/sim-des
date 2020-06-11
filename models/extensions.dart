extension TimeParsing on int {
  String toTimeString() {
    var d = Duration(minutes: this);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }
}
