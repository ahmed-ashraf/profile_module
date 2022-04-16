class RegisterEvent {}

class EmailChangedEvent extends RegisterEvent {
  bool isValid;
  String value;

  EmailChangedEvent(this.isValid, this.value);
}

class NameChangedEvent extends RegisterEvent {
  bool isValid;
  String value;

  NameChangedEvent(this.isValid, this.value);
}
class SubmitEvent extends RegisterEvent {}

class AcceptTerms extends RegisterEvent {
  bool isAccepted;

  AcceptTerms(this.isAccepted);
}

class GoogleSignInEvent extends RegisterEvent {}

class FacebookSignInEvent extends RegisterEvent {}

class PasswordChangedEvent extends RegisterEvent {
  bool isValid;
  String value;

  PasswordChangedEvent(this.isValid, this.value);
}