import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:normal/normal.dart';

import 'models/processador.dart';
import 'models/separator.dart';
import 'models/generator.dart';
import './redux/reducer.dart';
import './models/sim_state.dart';
import 'package:redux/redux.dart';
import './redux/actions.dart';
import './models/extensions.dart';
import 'globals.dart';

loggingMiddleware(Store<SimState> store, action, NextDispatcher next) {
  if (!(action
          is OneClock /* ||
      action is SeparatorToGroup2 ||
      action is SeparatorToGroup1 */
      )) {
    print('${store.state.CLK.toTimeString()} CLK: $action');
  }

  next(action);
}

void main() {
  print('Llegint excel...');
  readInputData();
  print('Done!');

  // Seed for random
  Generator.seed = inputNumber("INPUT: Indica una seed");

  // Initialize
  int capacitatRentadora = inputNumber(
      "INPUT: Indica la capacitat de les rentadores (int, default 50)", 50);
  int capacitatSecadora = inputNumber(
      "INPUT: Indica la capacitat de les secadores (int, default 50)", 50);

  print("ESTAT: Iniciant màquinaria");
  // Durations in minutes (normal distribution)
  int duracioRentadora =
      Normal.generate(1, mean: 45, variance: 2, seed: Generator.seed)
          .first
          .round();
  int duracioSecadora =
      Normal.generate(1, mean: 30, variance: 2, seed: Generator.seed)
          .first
          .round();
  int duracioPlanxa =
      Normal.generate(1, mean: 4, variance: 2, seed: Generator.seed)
          .first
          .round();
  final store = new Store<SimState>(
    simReducer,
    initialState: SimState.initialState(queue0: Generator.generateTextile(0)),
    middleware: [loggingMiddleware],
  );

  Separator separator = Separator();
  Processador rentadora1 =
      Processador(capacitat: capacitatRentadora, duracio: duracioRentadora);
  Processador rentadora2 =
      Processador(capacitat: capacitatRentadora, duracio: duracioRentadora);
  Processador secadora1 =
      Processador(capacitat: capacitatSecadora, duracio: duracioSecadora);
  Processador secadora2 =
      Processador(capacitat: capacitatSecadora, duracio: duracioSecadora);
  Processador planxa = Processador(capacitat: 1, duracio: duracioPlanxa);

  // Running
  print("ESTAT: Running");
  while (store.state.CLK < (8 * 60)) {
    separator.processa(
        clock: store.state.CLK,
        textils: store.state.queue0,
        toDamaged: (textils) => store.dispatch(DamagedTextiles(textils)),
        toGroup1: (textils) => store.dispatch(SeparatorToGroup1(textils)),
        toGroup2: (textils) => store.dispatch(SeparatorToGroup2(textils)));

    rentadora1.processa(
        store.state.CLK,
        store.state.queue1.length >= rentadora1.capacitat,
        () => store.dispatch(Rentadora1Loaded(rentadora1.capacitat)),
        () => store.dispatch(Rentadora1Done(rentadora1.capacitat)));

    rentadora2.processa(
        store.state.CLK,
        store.state.queue2.length >= rentadora2.capacitat,
        () => store.dispatch(Rentadora2Loaded(rentadora2.capacitat)),
        () => store.dispatch(Rentadora2Done(rentadora2.capacitat)));

    secadora1.processa(
        store.state.CLK,
        store.state.queue3.length >= secadora1.capacitat,
        () => store.dispatch(Secadora1Loaded(secadora1.capacitat)),
        () => store.dispatch(Secadora1Done(secadora1.capacitat)));

    secadora2.processa(
        store.state.CLK,
        store.state.queue4.length >= secadora2.capacitat,
        () => store.dispatch(Secadora2Loaded(secadora2.capacitat)),
        () => store.dispatch(Secadora2Done(secadora2.capacitat)));

    planxa.processa(
        store.state.CLK,
        store.state.queue5.length >= planxa.capacitat,
        () => store.dispatch(PlanxaLoaded(planxa.capacitat)),
        () => store.dispatch(PlanxaDone(planxa.capacitat)));

    store.dispatch(OneClock());
  }
  store.dispatch(SimFinished());
}

int inputNumber(String text, [int defaultNum]) {
  print(text);
  String string = stdin.readLineSync(encoding: Encoding.getByName('utf-8'));
  if (string?.isEmpty ?? true && defaultNum != null) return defaultNum;
  int x = int.parse(string);
  assert(x is int);
  return x;
}

readInputData() {
  var file = "files/InputData.xlsx";
  var bytes = File(file).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  for (var table in excel.tables.keys) {
    for (var row in excel.tables[table].rows) {
      textileTypes.insert(row[1].round(), row[0]);
    }
  }
}
