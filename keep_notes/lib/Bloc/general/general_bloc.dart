import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'general_event.dart';
part 'general_state.dart';

class GeneralBloc extends Bloc<GeneralEvent, GeneralState> {
  GeneralBloc() : super(const GeneralState()) {
    on<IsScrollTopAppBarEvent>(_isScrollTopAppBar);
  }

  //Todo: isScrollAppBar
  Future<void> _isScrollTopAppBar(
      IsScrollTopAppBarEvent event, Emitter<GeneralState> emit) async {
    emit(state.copyWith(isScrollAppBar: event.isScroll));
  }
}
