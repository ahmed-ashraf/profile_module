
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_module/components/input_validators/bloc/validate_error.dart';
import 'package:profile_module/components/input_validators/bloc/validate_state.dart';

class ValidateTextBloc extends Bloc<ValidateEvent, ValidateState> {
  ValidateTextBloc() : super(ValidateSuccessState()) {
    on<ValidateEvent>((event, emit) {
      if (event is ValidateChangedEvent && event.value.isEmpty) {
        emit(ValidateSuccessState());
      } else if (event is ValidateChangedEvent) {
        if ((event.validator == null &&
                (event.value.isEmpty || event.value.length < 3)) ||
            event.validator!.call(event.value) == false) {
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
