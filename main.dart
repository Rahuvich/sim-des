import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:normal/normal.dart';

import 'models/processador.dart';
import 'models/generator.dart';
import './redux/reducer.dart';
import './models/sim_state.dart';
import 'package:redux/redux.dart';
import './redux/actions.dart';
import './models/extensions.dart';
import 'globals.dart';

loggingMiddleware(Store<SimState> store, action, NextDispatcher next) {
  if (!(action is OneClock)) {
    print('${store.state.CLK.toTimeString()} CLK: $action');
  }

  next(action);
}

void main() {
  // Seed for random
  seed = inputNumber("INPUT: Indica una seed");

  // Initialize
  int capacitatRentadora = inputNumber(
      "INPUT: Indica la capacitat de la rentadora (int, default 50)", 50);
  int capacitatSecadora = inputNumber(
      "INPUT: Indica la capacitat de la secadora (int, default 50)", 50);
  
  // Durations in minutes (normal distribution)
  int duracioRentadora = Normal.generate(1, mean: 45, variance: 2, seed: seed).first.round();
  int duracioSecadora = Normal.generate(1, mean: 30, variance: 2, seed: seed).first.round();

  print("ESTAT: Iniciant màquinaria");
  final store = new Store<SimState>(
    simReducer,
    initialState: SimState.initialState(queue0: Generator.generateTextile(0)),
    middleware: [loggingMiddleware],
  );

  Processador rentadora =
      Processador(capacitat: capacitatRentadora, duracio: duracioRentadora);
  Processador secadora =
      Processador(capacitat: capacitatSecadora, duracio: duracioSecadora);

  // Running
  print("ESTAT: Running");

  while (store.state.CLK < (8 * 60)) {
    rentadora.processa(
        store.state.CLK,
        store.state.queue0.length >= rentadora.capacitat,
        () => store.dispatch(RentadoraLoaded(rentadora.capacitat)),
        () => store.dispatch(RentadoraDone(rentadora.capacitat)));

    secadora.processa(
        store.state.CLK,
        store.state.queue3.length >= secadora.capacitat,
        () => store.dispatch(SecadoraLoaded(secadora.capacitat)),
        () => store.dispatch(SecadoraDone(secadora.capacitat)));

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



