
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_module/components/input_validators/bloc/validate_error.dart';
import 'package:profile_module/components/input_validators/bloc/validate_state.dart';

class ValidateMailBloc extends Bloc<ValidateEvent, ValidateState> {
  ValidateMailBloc() : super(ValidateSuccessState()) {
    on<ValidateEvent>((event, emit) {
      if (event is ValidateChangedEvent && event.value.isEmpty) {
        emit(ValidateSuccessState());
      } else if (event is ValidateChangedEvent) {
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(event.value);
        if (!emailValid) {
          event.validate.call(event.value, false);
          emit(ValidateErrorState(ValidateError.notValid));
          return;
        }
        event.validate.call(event.value, true);
        emit(ValidateSuccessState());
      }
    });
  }
}
