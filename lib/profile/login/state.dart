class LoginSuccessState extends LoginState {}

abstract class LoginState {}

class IsDataValidState extends LoginState {}

class LoadingState extends LoginState {
  bool isLoading;

  LoadingState(this.isLoading);
}



class IsDataNotValidState extends LoginState {}

class LoginFailed extends LoginState {
  String message;

  LoginFailed(this.message);
}