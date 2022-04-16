class LoginEvent {}

class EmailChangedEvent extends LoginEvent {
  bool isValid;
  String value;

  EmailChangedEvent(this.isValid, this.value);
}

class SubmitEvent extends LoginEvent {}

class PasswordChangedEvent extends LoginEvent {
  bool isValid;
  String value;

  PasswordChangedEvent(this.isValid, this.value);
}

class GoogleSignInEvent extends LoginEvent {}

class FacebookSignInEvent extends LoginEvent {}