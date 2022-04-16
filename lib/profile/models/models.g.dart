// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordRequest _$ForgetPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ForgetPasswordRequest(
      json['email'] as String,
    );

Map<String, dynamic> _$ForgetPasswordRequestToJson(
        ForgetPasswordRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

VerifyForgetPasswordRequest _$VerifyForgetPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    VerifyForgetPasswordRequest(
      json['email'] as String,
      json['verifyCode'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$VerifyForgetPasswordRequestToJson(
        VerifyForgetPasswordRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'verifyCode': instance.verifyCode,
      'password': instance.password,
    };

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      json['email'] as String,
      json['password'] as String,
    )..isPasswordHashed = json['isPasswordHashed'] as bool;

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'isPasswordHashed': instance.isPasswordHashed,
    };

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      json['statusCode'] as int,
      json['data'],
      json['message'] as String,
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'statusCode': instance.statusCode,
      'message': instance.message,
    };

ResendVerifyRequest _$ResendVerifyRequestFromJson(Map<String, dynamic> json) =>
    ResendVerifyRequest(
      json['email'] as String,
    );

Map<String, dynamic> _$ResendVerifyRequestToJson(
        ResendVerifyRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

VerifyRequest _$VerifyRequestFromJson(Map<String, dynamic> json) =>
    VerifyRequest(
      json['email'] as String,
      json['code'] as String,
    );

Map<String, dynamic> _$VerifyRequestToJson(VerifyRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
    };

UpdateProfileRequest _$UpdateProfileRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileRequest(
      Firstname: json['Firstname'] as String?,
      Lastname: json['Lastname'] as String?,
      Phone: json['Phone'] as String?,
      Gender: json['Gender'] as String?,
      Description: json['Description'] as String?,
      FbAccount: json['FbAccount'] as String?,
      InstagramAccount: json['InstagramAccount'] as String?,
      TwitterAccount: json['TwitterAccount'] as String?,
    );

Map<String, dynamic> _$UpdateProfileRequestToJson(
        UpdateProfileRequest instance) =>
    <String, dynamic>{
      'Firstname': instance.Firstname,
      'Lastname': instance.Lastname,
      'Phone': instance.Phone,
      'Gender': instance.Gender,
      'Description': instance.Description,
      'FbAccount': instance.FbAccount,
      'InstagramAccount': instance.InstagramAccount,
      'TwitterAccount': instance.TwitterAccount,
    };

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      json['firstName'] as String,
      json['lastName'] as String,
      json['userName'] as String,
      json['email'] as String,
      json['password'] as String,
      dateOfBirth: json['dateOfBirth'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
      'email': instance.email,
      'password': instance.password,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'phone': instance.phone,
    };

GoogleSignInRequest _$GoogleSignInRequestFromJson(Map<String, dynamic> json) =>
    GoogleSignInRequest(
      json['accessToken'] as String,
    );

Map<String, dynamic> _$GoogleSignInRequestToJson(
        GoogleSignInRequest instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['statusCode'] as int,
      json['message'] as String,
      data: json['data'] == null
          ? null
          : UserData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'statusCode': instance.statusCode,
      'message': instance.message,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      phone: json['phone'],
      profilePictureUrl: json['profilePictureUrl'],
      description: json['description'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      facebookUrl: json['facebookUrl'],
      instagramUrl: json['instagramUrl'],
      twitterUrl: json['twitterUrl'],
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'profilePictureUrl': instance.profilePictureUrl,
      'description': instance.description,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'instagramUrl': instance.instagramUrl,
      'facebookUrl': instance.facebookUrl,
      'twitterUrl': instance.twitterUrl,
    };
