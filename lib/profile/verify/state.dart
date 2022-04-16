class ErrorState extends VerifyState {
  String error;

  ErrorState(this.error);
}

class VerifyState {}

class LoadingState extends VerifyState {
  bool isLoading;

  LoadingState(this.isLoading);
}

class VerifySuccessState extends VerifyState {}

class VerifyCodeResent extends VerifyState {
  String message;

  VerifyCodeResent(this.message);
}