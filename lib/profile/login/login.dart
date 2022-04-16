import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/basic/dialoges.dart';
import '../../components/basic/loading_indicator.dart';
import '../../components/basic/rounded_button.dart';
import '../../components/basic/rounded_password_filed.dart';
import '../../components/input_validators/email_field_validator.dart';
import '../../routes/routes.dart';
import '../../storage/theme_colors.dart';
import '../profile_repository.dart';
import 'login_bloc.dart';

import 'event.dart';
import 'state.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String emailOrPhone = '', password = '';

  @override
  Widget build(BuildContext context) {
    double maxWidth = 500;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          // title: Text(AppLocalizations.of(context)!.login),
          ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(ProfileRepository()),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailed) {
              showErrorInFlushBar(context, AppLocalizations.of(context)!.error,
                  state.message);
            }

            if (state is LoginSuccessState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.home,
                    (Route<dynamic> route) => false,
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              bool isloading = false;
              if (state is LoadingState) {
                isloading = state.isLoading;
                if (isloading) {
                  FocusScope.of(context).unfocus();
                }
              }
              RoundedButton submitBtn = RoundedButton(
                text: AppLocalizations.of(context)!.login,
                press: () {
                  context.read<LoginBloc>().add(SubmitEvent());
                },
              );
              if (state is IsDataNotValidState) {
                submitBtn = RoundedButton(
                  text: AppLocalizations.of(context)!.login,
                  color: Colors.black38,
                );
              }
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(12),
                              child: SizedBox(
                                width: size.width * 0.6,
                                height: size.height * 0.12,
                                // child: Image.asset(
                                //   'assets/logo.png',
                                // ),
                              )),
                          SizedBox(
                            width: size.width,
                            height: 50,
                            child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.welcomeBack,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                )),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: RoundedButton(
                              textColor: Colors.black,
                              text: AppLocalizations.of(context)!.sign_in_with_google,
                              color: Colors.white,
                              icon: Image.asset(
                                'assets/google.png',
                                height: 20,
                                width: 20,
                              ),
                              borderSide: BorderSide(color: Colors.black38),
                              press: () {
                                BlocProvider.of<LoginBloc>(context)
                                    .add(GoogleSignInEvent());
                              },
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: RoundedButton(
                              color: ThemeColors.facebookColor,
                              text: AppLocalizations.of(context)!.sign_in_with_facebook,
                              icon: Image.asset(
                                'assets/facebook.png',
                                height: 20,
                                width: 20,
                              ),
                              press: () {
                                BlocProvider.of<LoginBloc>(context)
                                    .add(FacebookSignInEvent());
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  constraints: BoxConstraints(maxWidth: maxWidth / 2 - 10),
                                  width: size.width * 0.35,
                                  child: Divider(color: Colors.black54)),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(AppLocalizations.of(context)!.or),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  constraints: BoxConstraints(maxWidth: maxWidth / 2 - 10),
                                  width: size.width * 0.35,
                                  child: Divider(color: Colors.black54)),
                            ],
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            width: size.width * 0.9,
                            child: EmailFieldWithValidator(
                                hintText: AppLocalizations.of(context)!.email,
                                validate: (value, isValid) {
                                  BlocProvider.of<LoginBloc>(context)
                                      .add(EmailChangedEvent(isValid, value));
                                }),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            width: size.width * 0.9,
                            child: RoundedPasswordField(
                              hintText: AppLocalizations.of(context)!.password,
                              onChanged: (String value) {
                                BlocProvider.of<LoginBloc>(context)
                                    .add(PasswordChangedEvent(true, value));
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: size.width * 0.6,
                              ),
                              TextButton(
                                  onPressed: () => Navigator.pushNamed(context, Routes.forgetPassword),
                                  child: Text(AppLocalizations.of(context)!.forget_pass)),
                            ],
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: submitBtn,
                          ),
                          SizedBox(height: 15,)
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Text(AppLocalizations.of(context)!.do_not_have_account),
                          //     TextButton(
                          //         onPressed: () {},
                          //         child: Text(AppLocalizations.of(context)!.register))
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                  isloading
                      ? Container(
                    child: const Center(child: SizedBox(child: LoadingIndicator())),
                    decoration: BoxDecoration(color: Color(0x4B575757)),
                  )
                      : Container(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
