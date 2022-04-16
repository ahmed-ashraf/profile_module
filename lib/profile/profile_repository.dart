import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../network/api.dart';
import '../network/dio_connectivity_request_retrier.dart';
import '../network/retry_interceptor.dart';
import '../storage/logged_user_data.dart';
import 'errors/failure_entity.dart';
import 'models/models.dart';

class ProfileRepository {
  final Dio _dio = Dio();

  ProfileRepository() {
    _dio.interceptors.add(RetryOnConnectionChangeInterceptor(
        DioConnectivityRequestRetrier(
            dio: _dio, connectivity: Connectivity())));
  }

  Future<Either<FailureEntity, RegisterResponse>> forgetPassword(
      ForgetPasswordRequest request) async {
    try {
      Response<dynamic> response = await _dio.get(
        Api.forgetPassword,
        queryParameters: request.toJson(),
      );
      return Right(RegisterResponse.fromJson(response.data));
    } on TypeError {
      return Left(DataParsingException());
    } on SocketException {
      return Left(NoConnectionException());
    }
  }

  Future<Either<FailureEntity, RegisterResponse>> verifyForgetPassword(
      VerifyForgetPasswordRequest request) async {
    try {
      Response<dynamic> response = await _dio.post(
        Api.verifyForgetPassword,
        data: jsonEncode(request.toJson()),
      );
      return Right(RegisterResponse.fromJson(response.data));
    } on TypeError {
      return Left(DataParsingException());
    } on SocketException {
      return Left(NoConnectionException());
    }
  }

  Future<Either<FailureEntity, LoginResponse>> googleSignIn(
      GoogleSignInRequest request) async {
    try {
      Response<dynamic> response = await _dio.post(
        Api.googleLogin,
        data: jsonEncode(request.toJson()),
      );
      return Right(LoginResponse.fromJson(response.data));
    } on TypeError {
      return Left(DataParsingException());
    } on SocketException {
      return Left(NoConnectionException());
    }
  }

  Future<Either<FailureEntity, LoginResponse>> facebookSignIn(
      GoogleSignInRequest request) async {
    try {
      Response<dynamic> response = await _dio.post(
        Api.faceBookLogin,
        data: jsonEncode(request.toJson()),
      );
      return Right(LoginResponse.fromJson(response.data));
    } on TypeError {
      return Left(DataParsingException());
    } on SocketException {
      return Left(NoConnectionException());
    }
  }

  Future<Either<FailureEntity, LoginResponse>> login(
      LoginRequest request) async {
    try {
      Response<dynamic> response = await _dio.post(
        Api.login,
        data: jsonEncode(request.toJson()),
      );
      return Right(LoginResponse.fromJson(response.data));
    } on TypeError {
      return Left(DataParsingException());
    } on SocketException {
      return Left(NoConnectionException());
    }
  }

  Future<Either<FailureEntity, RegisterResponse>> updateProfile(
      UpdateProfileRequest request, XFile? Picture) async {
    try {
      Map<String, dynamic> map = request.toJson();
      if (Picture != null)
        map.addAll({'Picture': (await MultipartFile.fromFile(Picture.path))});
      Response<dynamic> response = await _dio.post(
        Api.updateUserProfile + '?userId=${LoggedUserData.get()!.id}',
        data: FormData.fromMap(map),
      );
      return Right(RegisterResponse.fromJson(response.data));
    } on TypeError {
      return Left(DataParsingException());
    } on SocketException {
      return Left(NoConnectionException());
    }
  }

  Future<Either<FailureEntity, RegisterResponse>> register(
      RegisterRequest request) async {
    try {
      Response<dynamic> response = await _dio.post(
        Api.register,
        data: jsonEncode(request.toJson()),
      );
      return Right(RegisterResponse.fromJson(response.data));
    } on TypeError {
      return Left(DataParsingException());
    } on SocketException {
      return Left(NoConnectionException());
    }
  }

  Future<Either<FailureEntity, LoginResponse>> verify(
      VerifyRequest request) async {
    try {
      Response<dynamic> response = await _dio.get(
        Api.verifyEmailCode,
        queryParameters: request.toJson(),
      );
      return Right(LoginResponse.fromJson(response.data));
    } on TypeError {
      return Left(DataParsingException());
    } on SocketException {
      return Left(NoConnectionException());
    }
  }

  Future<Either<FailureEntity, RegisterResponse>> resendCode(
      ResendVerifyRequest request) async {
    try {
      Response<dynamic> response = await _dio.get(Api.resendEmailCode,
          queryParameters: request.toJson());
      return Right(RegisterResponse.fromJson(response.data));
    } on TypeError {
      return Left(DataParsingException());
    } on SocketException {
      return Left(NoConnectionException());
    }
  }
}
