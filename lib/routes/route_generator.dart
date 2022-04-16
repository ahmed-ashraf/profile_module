import 'package:flutter/material.dart';

import '../profile/forgetPassword/forget_pass_enter_code.dart';
import '../profile/forgetPassword/forget_password.dart';
import '../profile/login/login.dart';
import '../profile/register/register.dart';
import '../profile/update_profile/update_profile.dart';
import '../profile/verify/verify.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case Routes.signIn:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.verify:
        if (args is VerificationArgs) {
          return MaterialPageRoute(builder: (_) => VerificationPage(args));
        } else {
          return _errorRoute();
        }
      case Routes.updateProfile:
        return MaterialPageRoute(builder: (_) => UpdateProfilePage());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgetPasswordPage());
      case Routes.verifyForgetPassword:
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => ForgetPassEnterCodePage(email: args,));
        } else {
          return _errorRoute();
        }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
