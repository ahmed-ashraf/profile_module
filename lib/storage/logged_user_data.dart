import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

part 'logged_user_data.g.dart';

@HiveType(typeId: 1)
enum LoginType {
  @HiveField(0)
  facebook,
  @HiveField(1)
  google,
  @HiveField(2)
  normal
}

@HiveType(typeId: 0)
class LoggedUserData {
  @HiveField(0)
  int id;
  @HiveField(1)
  String fullName;
  @HiveField(2)
  String phone;
  @HiveField(3)
  String profilePictureUrl;
  @HiveField(4)
  String description;
  @HiveField(5)
  String token;
  @HiveField(6)
  String refreshToken;
  @HiveField(7)
  String email;
  @HiveField(8)
  String firstName;
  @HiveField(9)
  String lastName;
  @HiveField(10)
  String instagramUrl;
  @HiveField(11)
  String facebookUrl;
  @HiveField(12)
  String twitterUrl;

  LoggedUserData(
      this.id,
      this.email,
      this.fullName,
      this.phone,
      this.profilePictureUrl,
      this.description,
      this.token,
      this.refreshToken,
      this.firstName,
      this.lastName,
      this.twitterUrl,
      this.instagramUrl,
      this.facebookUrl);

  store(LoginType loginType) {
    var box = Hive.box('logged_user_data');
    box.put('logged_user', this);
    box.put('login_type', loginType);
  }

  update() {
    var box = Hive.box('logged_user_data');
    box.put('logged_user', this);
  }

  static LoggedUserData? get() {
    var box = Hive.box('logged_user_data');
    return box.get('logged_user');
  }

  static LoginType? getLoginType() {
    var box = Hive.box('logged_user_data');
    return box.get('login_type');
  }

  static Future logout() async {
    Box box = Hive.box('logged_user_data');
    LoginType? loginType = box.get('login_type');
    if (loginType != null) {
      if (loginType == LoginType.facebook) {
        await FacebookAuth.instance.logOut();
      } else if (loginType == LoginType.google) {
        GoogleSignIn _googleSignIn = GoogleSignIn();
        await _googleSignIn.signOut();
      }
    }
    box.clear();
  }
}
