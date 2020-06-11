import 'processador.dart';
import 'textile.dart';

class SimState {
  final int CLK;
  final List<Textile> queue0;
  final List<Textile> queue1;
  final List<Textile> queue2;
  final List<Textile> queue3;
  final List<Textile> queue4;
  final List<Textile> queue5;
  final List<Textile> doneQueue;

  final List<Textile> rentadora1;
  final List<Textile> rentadora2;

  final List<Textile> secadora1;
  final List<Textile> secadora2;

  final List<Textile> planxa;

  factory SimState.initialState({
    List<Textile> queue0,
  }) {
    return SimState(
      queue0: queue0,
      queue1: [],
      queue2: [],
      queue3: [],
      queue4: [],
      queue5: [],
      doneQueue: [],
      CLK: 0,
    );
  }

  SimState copyWith(SimState state) {
    return SimState(
        CLK: state.CLK,
        queue0: state.queue0,
        queue1: state.queue1,
        queue2: state.queue2,
        queue3: state.queue3,
        queue4: state.queue4,
        queue5: state.queue5,
        rentadora1: state.rentadora1,
        rentadora2: state.rentadora2,
        secadora1: state.secadora1,
        secadora2: state.secadora2,
        planxa: state.planxa,
        doneQueue: state.doneQueue);
  }

  SimState(
      {this.CLK,
      this.queue0,
      this.queue1,
      this.queue2,
      this.queue3,
      this.queue4,
      this.queue5,
      this.secadora1,
      this.secadora2,
      this.planxa,
      this.rentadora1,
      this.rentadora2,
      this.doneQueue});
}
