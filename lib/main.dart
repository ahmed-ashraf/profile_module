import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:profile_module/profile/login/login.dart';
import 'package:profile_module/profile/register/register.dart';
import 'package:profile_module/storage/logged_user_data.dart';
import 'package:profile_module/storage/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'routes/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Paint.enableDithering = true;
  Hive
    ..init(dir.path)
    ..registerAdapter(LoggedUserDataAdapter())
    ..registerAdapter(LoginTypeAdapter());
  await Hive.openBox('logged_user_data');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => LoggedUserData.get()),
        // ChangeNotifierProvider(create: (_) => UserDataNotifier()),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFFFFFF),
            titleTextStyle: TextStyle(fontSize: 20, color: ThemeColors.grey),
            // centerTitle: true,
            shadowColor: Color(0x00000000),
            iconTheme: IconThemeData(color: ThemeColors.grey),
          ),
          primarySwatch: const MaterialColor(
            0xff306984,
            <int, Color>{
              50: Color(0xffd43087),
              100: Color(0xffd43087),
              200: Color(0xffd43087),
              300: Color(0xffd43087),
              400: Color(0xffd43087),
              500: Color(0xffd43087),
              600: Color(0xffd43087),
              700: Color(0xffd43087),
              800: Color(0xffd43087),
              900: Color(0xffd43087),
            },
          ),
        ),
        home: LoggedUserData.getLoginType() != null ? RegisterPage() : RegisterPage(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
