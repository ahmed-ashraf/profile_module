import 'package:flutter/foundation.dart';

import 'logged_user_data.dart';

class UserDataNotifier extends ChangeNotifier {
  LoggedUserData? _loggedUserData;

  UserDataNotifier() {
    _loggedUserData = LoggedUserData.get();
  }

  set loggedUserData(LoggedUserData value) {
    _loggedUserData = value;
    notifyListeners();
  }

  LoggedUserData get loggedUserData => _loggedUserData!;
}