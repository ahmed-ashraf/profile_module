abstract class UpdateProfileState {}

class InitState extends UpdateProfileState {}

class IsDataValidState extends UpdateProfileState {}

class IsDataNotValidState extends UpdateProfileState {}

class LoadingState extends UpdateProfileState {
  bool isLoading;

  LoadingState(this.isLoading);
}

class SuccessState extends UpdateProfileState {
  String msg;

  SuccessState(this.msg);
}

class FailState extends UpdateProfileState {
  String msg;

  FailState(this.msg);
}