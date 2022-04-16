// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacbookAuth {
  // final fbLogin = FacebookLogin();

  Future<String?> signInFB() async {
    try {
      final LoginResult result = await FacebookAuth.instance
          .login(); // by default we request the email and the public profile

      if (result.status == LoginStatus.success) {
        // you are logged

        final AccessToken accessToken = result.accessToken!;

        final userData = await FacebookAuth.i.getUserData();
        return accessToken.token;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
