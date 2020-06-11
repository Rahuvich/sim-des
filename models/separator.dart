import 'package:normal/normal.dart';

import 'textile.dart';
import 'dart:math';

class Separator {
  int duracio;
  int clock_last_separated = 0;

  Separator()
      : duracio = Normal.generate(1, mean: 3, variance: 1).first.round();

  processa(
      {int clock,
      List<Textile> textils,
      Function(List<Textile>) toGroup1,
      Function(List<Textile>) toGroup2}) {
    if (textils.isEmpty) return;

    List<Textile> group1,
        group2,
        subgroupThisClockTime = textils.sublist(
            0, min(textils.length, _quantitatTextilsPerClock(clock)));

    group1 =
        subgroupThisClockTime.where((textil) => textil.tipus <= 2).toList();
    group2 = subgroupThisClockTime.where((textil) => textil.tipus > 2).toList();

    if (group2.isNotEmpty || group1.isNotEmpty) {
      clock_last_separated = clock;
    }

    if (group1.isNotEmpty) toGroup1(group1);
    if (group2.isNotEmpty) toGroup2(group2);
  }

  int _quantitatTextilsPerClock(clock) =>
      ((clock - clock_last_separated) / duracio).floor();
}
