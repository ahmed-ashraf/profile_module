
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_module/components/input_validators/bloc/validate_error.dart';
import 'package:profile_module/components/input_validators/bloc/validate_state.dart';

class ValidatePasswordBloc extends Bloc<ValidateEvent, ValidateState> {
  ValidatePasswordBloc() : super(ValidateSuccessState()) {
    on<ValidateEvent>((event, emit) {
      if (event is ValidateChangedEvent && event.value.isEmpty) {
        emit(ValidateSuccessState());
      } else if (event is ValidateChangedEvent) {
        if (!RegExp(r"^(?:(?=.*[a-z])(?:(?=.*[A-Z])(?=.*[\d\W])|(?=.*\W)(?=.*\d))|(?=.*\W)(?=.*[A-Z])(?=.*\d)).{8,}$")
            .hasMatch(event.value)) {
          event.validate.call(event.value, false);
          emit(ValidateErrorState(ValidateError.notValid));
          return;
        } else {
          event.validate.call(event.value, true);
          emit(ValidateSuccessState());
        }
      }
    });
  }
}
