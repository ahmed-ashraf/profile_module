import 'dart:io';

Map<String, String> headers = {
  'Accept-Language': 'ar',
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'api_key': Api.apiKey,
  'platform': Platform.isAndroid ? 'android' : 'ios',
  'version': Platform.version,
  'mob_api_version': 'v_1.0'
};

class Api {
  static const apiKey = "api_key";
  static const String apiUrl = 'url';

  static const String googleLogin = '${apiUrl}api/account/login/google';
  static const String faceBookLogin = '${apiUrl}api/account/login/facebook';
  static const String login = '${apiUrl}api/account/login';
  static const String register = '${apiUrl}api/account/register';
  static const String verifyEmailCode = '${apiUrl}api/account/verify-email-code';
  static const String resendEmailCode = '${apiUrl}api/account/resend-email-code';
  static const String updateUserProfile = '${apiUrl}api/user/UpdateUserProfile';
  static const String forgetPassword = '${apiUrl}api/account/forget-password';
  static const String verifyForgetPassword = '${apiUrl}api/account/verify-forget-password';
}