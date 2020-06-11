import '../models/sim_state.dart';
import 'actions.dart';
import '../models/generator.dart';
import '../models/textile.dart';
import 'dart:math';

SimState simReducer(SimState state, action) {
  if (action is SimFinished) {
    print(
        "ESTAT: S'ha acabat la simulacio amb ${state.doneQueue.length} peces netes i ${state.damagedQueue.length} peces danyades");
    return state;
  }

  return SimState(
    CLK: (action is OneClock) ? state.CLK + 1 : state.CLK,
    queue0: queue0Reducer(
        state.queue0, Generator.generateTextile(state.CLK), action),
    queue1: queue1Reducer(state.queue1, action),
    queue2: queue2Reducer(state.queue2, action),
    queue3: queue3Reducer(state.queue3, state.rentadora1, action),
    queue4: queue4Reducer(state.queue4, state.rentadora2, action),
    queue5: queue5Reducer(state.queue5, state.secadora2, action),
    doneQueue: doneQueueReducer(
        state.doneQueue, state.secadora1, state.planxa, action),
    rentadora1: rentadora1Reducer(state.rentadora1, state.queue1, action),
    rentadora2: rentadora2Reducer(state.rentadora2, state.queue2, action),
    secadora1: secadora1Reducer(state.secadora1, state.queue3, action),
    secadora2: secadora2Reducer(state.secadora2, state.queue4, action),
    planxa: planxaReducer(state.planxa, state.queue5, action),
    damagedQueue: damagedQueueReducer(state.damagedQueue, action),
  );
}

List<Textile> queue0Reducer(
    List<Textile> prevState, List<Textile> nextTruck, action) {
  if (action is Rentadora1Loaded) {
    if (action.capacity > prevState.length) return List.unmodifiable([]);
    return prevState.sublist(action.capacity);
  }

  if (action is SeparatorToGroup1 ||
      action is SeparatorToGroup2 ||
      action is DamagedTextiles) {
    List<Textile> aux = List.from(prevState);
    aux.removeWhere((textil) => action.textils.contains(textil));
    return aux;
  }

  return List.unmodifiable([]..addAll(prevState)..addAll(nextTruck));
}

List<Textile> queue1Reducer(List<Textile> prevState, action) {
  if (action is SeparatorToGroup1) {
    return List.unmodifiable([]..addAll(prevState)..addAll(action.textils));
  }
  return prevState;
}

List<Textile> queue2Reducer(List<Textile> prevState, action) {
  if (action is SeparatorToGroup2) {
    return List.unmodifiable([]..addAll(prevState)..addAll(action.textils));
  }
  return prevState;
}

List<Textile> queue3Reducer(
    List<Textile> prevState, List<Textile> rentadora, action) {
  if (action is Rentadora1Done) {
    return List.unmodifiable([]..addAll(prevState)..addAll(rentadora));
  }
  if (action is Secadora1Loaded) {
    if (action.capacity > prevState.length) return List.unmodifiable([]);
    return prevState.sublist(action.capacity);
  }
  return prevState;
}

List<Textile> queue4Reducer(
    List<Textile> prevState, List<Textile> rentadora, action) {
  if (action is Rentadora2Done) {
    return List.unmodifiable([]..addAll(prevState)..addAll(rentadora));
  }
  if (action is Secadora2Loaded) {
    if (action.capacity > prevState.length) return List.unmodifiable([]);
    return prevState.sublist(action.capacity);
  }
  return prevState;
}

List<Textile> queue5Reducer(
    List<Textile> prevState, List<Textile> secadora, action) {
  if (action is Secadora2Done) {
    return List.unmodifiable([]..addAll(prevState)..addAll(secadora));
  }
  if (action is PlanxaLoaded) {
    if (action.capacity > prevState.length) return List.unmodifiable([]);
    return prevState.sublist(action.capacity);
  }
  return prevState;
}

List<Textile> doneQueueReducer(List<Textile> prevState, List<Textile> secadora1,
    List<Textile> planxa, action) {
  if (action is Secadora1Done) {
    return List.unmodifiable([]..addAll(prevState)..addAll(secadora1));
  }
  if (action is PlanxaDone) {
    return List.unmodifiable([]..addAll(prevState)..addAll(planxa));
  }
  return prevState;
}

List<Textile> damagedQueueReducer(List<Textile> prevState, action) {
  if (action is DamagedTextiles) {
    return List.unmodifiable([]..addAll(prevState)..addAll(action.textils));
  }
  return prevState;
}

List<Textile> rentadora1Reducer(
    List<Textile> prevState, List<Textile> waitingQueue, action) {
  if (action is Rentadora1Loaded) {
    return List.unmodifiable([]..addAll(
        waitingQueue.sublist(0, min(action.capacity, waitingQueue.length))));
  }
  if (action is Rentadora1Done) {
    return List.unmodifiable([]);
  }
  return prevState;
}

List<Textile> rentadora2Reducer(
    List<Textile> prevState, List<Textile> waitingQueue, action) {
  if (action is Rentadora2Loaded) {
    return List.unmodifiable([]..addAll(
        waitingQueue.sublist(0, min(action.capacity, waitingQueue.length))));
  }
  if (action is Rentadora2Done) {
    return List.unmodifiable([]);
  }
  return prevState;
}

List<Textile> secadora1Reducer(
    List<Textile> prevState, List<Textile> waitingQueue, action) {
  if (action is Secadora1Loaded) {
    return List.unmodifiable([]..addAll(
        waitingQueue.sublist(0, min(action.capacity, waitingQueue.length)) ??
            []));
  }
  if (action is Secadora1Done) {
    return List.unmodifiable([]);
  }
  return prevState;
}

List<Textile> secadora2Reducer(
    List<Textile> prevState, List<Textile> waitingQueue, action) {
  if (action is Secadora2Loaded) {
    return List.unmodifiable([]..addAll(
        waitingQueue.sublist(0, min(action.capacity, waitingQueue.length)) ??
            []));
  }
  if (action is Secadora2Done) {
    return List.unmodifiable([]);
  }
  return prevState;
}

List<Textile> planxaReducer(
    List<Textile> prevState, List<Textile> waitingQueue, action) {
  if (action is PlanxaLoaded) {
    return List.unmodifiable([]..addAll(
        waitingQueue.sublist(0, min(action.capacity, waitingQueue.length)) ??
            []));
  }
  if (action is PlanxaDone) {
    return List.unmodifiable([]);
  }
  return prevState;
}
