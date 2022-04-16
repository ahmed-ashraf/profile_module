import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../logger/logger.dart';
import '../storage/logged_user_data.dart';
import 'api.dart';

class AppInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      logPrint('statusCode: ${response.statusCode.toString()}');
      logPrint(response.toString());
    }
    super.onResponse(response, handler);
  }
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = headers;
    if (LoggedUserData.getLoginType() != null) {
      options.headers.addAll({
        'Authorization': 'Bearer ${LoggedUserData.get()!.token}',
      });
    }
    options.followRedirects = false;
    options.validateStatus = (status) => status! < 500;

    if (kDebugMode) {
      logPrint('url: ${options.path}');
      logPrint('headers: ${options.headers}');
      logPrint('request: ${options.data}');
    }
    super.onRequest(options, handler);
  }
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      logPrint(err.message);
    }
    super.onError(err, handler);
  }
}
