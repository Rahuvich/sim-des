import '../models/sim_state.dart';
import 'actions.dart';
import '../models/generator.dart';
import '../models/textile.dart';
import 'dart:math';

SimState simReducer(SimState state, action) {
  if (action is SimFinished) {
    print(
        "ESTAT: S'ha acabat la simulacio amb ${state.doneQueue.length} peces netes i ${state.queue0.length} peces esperant");
    return state;
  }

  return SimState(
    CLK: (action is OneClock) ? state.CLK + 1 : state.CLK,
    queue0: queue0Reducer(
        state.queue0, Generator.generateTextile(state.CLK), action),
    rentadora1: rentadoraReducer(state.rentadora1, state.queue0, action),
    queue3: queue3Reducer(state.queue3, state.rentadora1, action),
    secadora1: secadoraReducer(state.secadora1, state.queue3, action),
    doneQueue: doneQueueReducer(state.doneQueue, state.secadora1, action),
  );
}

List<Textile> queue0Reducer(
    List<Textile> prevState, List<Textile> nextTruck, action) {
  if (action is RentadoraLoaded) {
    if (action.capacity > prevState.length) return List.unmodifiable([]);
    return prevState.sublist(action.capacity);
  }
  return List.unmodifiable([]..addAll(prevState)..addAll(nextTruck));
}

List<Textile> queue3Reducer(
    List<Textile> prevState, List<Textile> rentadora, action) {
  if (action is RentadoraDone) {
    return List.unmodifiable([]..addAll(prevState)..addAll(rentadora));
  }
  return prevState;
}

List<Textile> doneQueueReducer(
    List<Textile> prevState, List<Textile> waitingQueue, action) {
  List<Textile> l;
  if (action is SecadoraDone) {
    l = List.unmodifiable([]..addAll(prevState)..addAll(waitingQueue));
    print("ESTAT: Ara hi ha ${l.length} peces netes");
  } else {
    l = prevState;
  }
  return l;
}

List<Textile> rentadoraReducer(
    List<Textile> prevState, List<Textile> waitingQueue, action) {
  if (action is RentadoraLoaded) {
    return List.unmodifiable([]..addAll(
        waitingQueue.sublist(0, min(action.capacity, waitingQueue.length))));
  }
  if (action is RentadoraDone) {
    return List.unmodifiable([]);
  }
  return prevState;
}

List<Textile> secadoraReducer(
    List<Textile> prevState, List<Textile> waitingQueue, action) {
  if (action is SecadoraLoaded) {
    return List.unmodifiable([]..addAll(
        waitingQueue.sublist(0, min(action.capacity, waitingQueue.length)) ??
            []));
  }
  if (action is SecadoraDone) {
    return List.unmodifiable([]);
  }
  return prevState;
}
