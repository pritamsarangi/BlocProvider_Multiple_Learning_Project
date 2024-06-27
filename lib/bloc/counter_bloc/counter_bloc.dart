
import 'package:bloc/bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';


class CounterBloc extends Bloc<CounterEvent,CounterState>{
  CounterBloc() :super(const CounterState()){
    on<IncrementCounter>(_increment);
    on<DecrementCounter>(_decrement);
    on<ResetCounter>(_reset);
  }
  void _increment(IncrementCounter event, Emitter<CounterState> emitter){
    emitter(state.copyWith(counter: state.counter +1));
  }
  void _decrement(DecrementCounter event, Emitter<CounterState>emitter){
    emitter(state.copyWith(counter: state.counter -1));
  }
  void _reset(ResetCounter event, Emitter<CounterState>emitter){
    emitter(state.copyWith(counter: 0));
  }
}