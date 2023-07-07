import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    // Emisión del nuevo evento
    on<CounterIncreased>((event, emit) {
      emit(state.copyWith(
        counter: state.counter + event.value,
        transactionCounter: state.transactionCounter + 1,
      ));
    });
  }
}
