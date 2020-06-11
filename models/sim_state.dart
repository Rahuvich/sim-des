import 'textile.dart';

class SimState {
  final int CLK;
  final List<Textile> queue0;
  final List<Textile> queue1;
  final List<Textile> queue2;
  final List<Textile> queue3;
  final List<Textile> queue4;
  final List<Textile> queue5;
  final List<Textile> damagedQueue;

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
      damagedQueue: [],
      doneQueue: [],
      rentadora1: [],
      rentadora2: [],
      secadora1: [],
      secadora2: [],
      CLK: 1,
    );
  }

  SimState(
      {this.CLK,
      this.queue0,
      this.queue1,
      this.queue2,
      this.queue3,
      this.queue4,
      this.queue5,
      this.damagedQueue,
      this.secadora1,
      this.secadora2,
      this.planxa,
      this.rentadora1,
      this.rentadora2,
      this.doneQueue});
}
