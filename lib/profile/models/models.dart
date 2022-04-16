import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class ForgetPasswordRequest {
  String email;

  ForgetPasswordRequest(this.email);

  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ForgetPasswordRequestToJson(this);
}

@JsonSerializable()
class VerifyForgetPasswordRequest {
  String email;
  String verifyCode;
  String password;

  VerifyForgetPasswordRequest(this.email, this.verifyCode, this.password);

  factory VerifyForgetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyForgetPasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyForgetPasswordRequestToJson(this);
}

@JsonSerializable()
class LoginRequest {
  String email;
  String password;
  bool isPasswordHashed = false;

  LoginRequest(this.email, this.password);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class RegisterResponse {
  dynamic data;
  int statusCode;
  String message;

  RegisterResponse(this.statusCode, this.data, this.message);

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}

@JsonSerializable()
class ResendVerifyRequest {
  String email;

  ResendVerifyRequest(this.email);

  Map<String, dynamic> toJson() => _$ResendVerifyRequestToJson(this);
}

@JsonSerializable()
class VerifyRequest {
  String email;
  String code;

  VerifyRequest(this.email, this.code);

  Map<String, dynamic> toJson() => _$VerifyRequestToJson(this);
  factory VerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyRequestFromJson(json);
}

@JsonSerializable()
class UpdateProfileRequest {
  String? Firstname,
      Lastname,
      Phone,
      Gender,
      Description,
      FbAccount,
      InstagramAccount,
      TwitterAccount;

  UpdateProfileRequest(
      {this.Firstname,
      this.Lastname,
      this.Phone,
      this.Gender,
      this.Description,
      this.FbAccount,
      this.InstagramAccount,
      this.TwitterAccount});

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
@JsonSerializable()
class RegisterRequest {
  String firstName;
  String lastName;
  String userName;
  String email;
  String password;
  String? dateOfBirth;
  String? gender;
  String? phone;

  RegisterRequest(this.firstName, this.lastName, this.userName, this.email, this.password,
      {this.dateOfBirth, this.phone, this.gender});

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable()
class GoogleSignInRequest {
  String accessToken;

  GoogleSignInRequest(this.accessToken);
  Map<String, dynamic> toJson() => _$GoogleSignInRequestToJson(this);
}

@JsonSerializable()
class LoginResponse {
  UserData? data;
  int statusCode;
  String message;

  LoginResponse(this.statusCode, this.message, {this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  dynamic id;
  dynamic email;
  dynamic firstName;
  dynamic lastName;
  dynamic fullName;
  dynamic phone;
  dynamic profilePictureUrl;
  dynamic description;
  dynamic token;
  dynamic refreshToken;
  dynamic instagramUrl;
  dynamic facebookUrl;
  dynamic twitterUrl;

  UserData(
      {this.id,
      this.email,
      this.fullName,
      this.phone,
      this.profilePictureUrl,
      this.description,
      this.token,
      this.refreshToken,
      this.firstName,
      this.lastName,
      this.facebookUrl,
      this.instagramUrl,
      this.twitterUrl});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
