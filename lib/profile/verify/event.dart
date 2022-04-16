class VerifyEvent {}

class SubmitEvent extends VerifyEvent {
  String email;
  String code;

  SubmitEvent(this.email, this.code);
}

class ResendEvent extends VerifyEvent {
  String email;

  ResendEvent(this.email);
}