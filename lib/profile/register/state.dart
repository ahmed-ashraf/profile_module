class EmailRegisterSuccessState extends RegisterState {
  String email;

  EmailRegisterSuccessState(this.email);
}

class RegisterSuccessState extends RegisterState {}

abstract class RegisterState {}

class IsDataValidState extends RegisterState {}

class LoadingState extends RegisterState {
  bool isLoading;

  LoadingState(this.isLoading);
}


class IsDataNotValidState extends RegisterState {}

class RegisterFailed extends RegisterState {
  String message;

  RegisterFailed(this.message);
}