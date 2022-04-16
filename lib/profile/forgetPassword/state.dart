abstract class ForgetPasswordState {}

class InitState extends ForgetPasswordState {}

class IsDataValidState extends ForgetPasswordState {}

class IsDataNotValidState extends ForgetPasswordState {}

class LoadingState extends ForgetPasswordState {}

class SuccessState extends ForgetPasswordState {
  String msg;

  SuccessState(this.msg);
}

class FailState extends ForgetPasswordState {
  String msg;

  FailState(this.msg);
}