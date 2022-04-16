
import 'package:profile_module/components/input_validators/bloc/validate_error.dart';

abstract class ValidateState {}

class ValidateSuccessState extends ValidateState {}

class ValidateErrorState extends ValidateState {
  ValidateError error;

  ValidateErrorState(this.error);
}

abstract class ValidateEvent {}

class ValidateChangedEvent extends ValidateEvent {
  String value;
  Function validate;
  Function(String)? validator;

  ValidateChangedEvent(this.value, this.validate, {this.validator});
}
