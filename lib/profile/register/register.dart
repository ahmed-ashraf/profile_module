import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:profile_module/profile/register/register_bloc.dart';

import '../../components/basic/dialoges.dart';
import '../../components/basic/loading_indicator.dart';
import '../../components/basic/rounded_button.dart';
import '../../components/input_validators/email_field_validator.dart';
import '../../components/input_validators/password_field_validator.dart';
import '../../components/input_validators/text_field_validator.dart';
import '../../routes/routes.dart';
import '../../storage/theme_colors.dart';
import '../profile_repository.dart';
import '../verify/verify.dart';
import 'event.dart';
import 'state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String emailOrPhone = '', password = '', fullname = '';
  bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    double maxWidth = 500;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          // title: Text(AppLocalizations.of(context)!.login),
          ),
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(ProfileRepository()),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailed) {
              showErrorInFlushBar(
                  context, AppLocalizations.of(context)!.error, state.message);
            }

            if (state is EmailRegisterSuccessState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.verify, (Route<dynamic> route) => false,
                  arguments: VerificationArgs(state.email));
            }

            if (state is RegisterSuccessState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.home,
                (Route<dynamic> route) => false,
              );
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              bool isloading = false;
              if (state is LoadingState) {
                isloading = state.isLoading;
                if (isloading) {
                  FocusScope.of(context).unfocus();
                }
              }
              RoundedButton submitBtn = RoundedButton(
                text: AppLocalizations.of(context)!.register,
                press: () {
                  BlocProvider.of<RegisterBloc>(context).add(SubmitEvent());
                },
              );
              if (state is IsDataNotValidState) {
                submitBtn = RoundedButton(
                  text: AppLocalizations.of(context)!.register,
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
                              padding: const EdgeInsets.all(20),
                              child: SizedBox(
                                width: size.width * 0.5,
                                height: size.height * 0.1,
                                // child: Image.asset(
                                //   'assets/logo.png',
                                // ),
                              )),
                          SizedBox(
                            width: size.width,
                            height: 50,
                            child: Center(
                                child: Text(
                              AppLocalizations.of(context)!.get_started,
                              style: const TextStyle(fontSize: 20),
                            )),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: RoundedButton(
                              textColor: Colors.black,
                              text: AppLocalizations.of(context)!
                                  .sign_up_with_google,
                              color: Colors.white,
                              icon: Image.asset(
                                'assets/google.png',
                                height: 20,
                                width: 20,
                              ),
                              borderSide: const BorderSide(color: Colors.black38),
                              press: () =>
                                  BlocProvider.of<RegisterBloc>(context)
                                      .add(GoogleSignInEvent()),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: RoundedButton(
                              color: ThemeColors.facebookColor,
                              text: AppLocalizations.of(context)!
                                  .sign_up_with_facebook,
                              icon: Image.asset(
                                'assets/facebook.png',
                                height: 20,
                                width: 20,
                              ),
                              press: () =>
                                  BlocProvider.of<RegisterBloc>(context)
                                      .add(FacebookSignInEvent()),
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
                                  constraints: BoxConstraints(
                                      maxWidth: maxWidth / 2 - 10),
                                  width: size.width * 0.35,
                                  child: const Divider(color: Colors.black54)),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(AppLocalizations.of(context)!.or),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  constraints: BoxConstraints(
                                      maxWidth: maxWidth / 2 - 10),
                                  width: size.width * 0.35,
                                  child: const Divider(color: Colors.black54)),
                            ],
                          ),
                          Container(
                              constraints: BoxConstraints(maxWidth: maxWidth),
                              width: size.width * 0.9,
                              child: TextFieldWithValidator(
                                hintText:
                                    AppLocalizations.of(context)!.full_name,
                                validate: (value, isValid) {
                                  BlocProvider.of<RegisterBloc>(context)
                                      .add(NameChangedEvent(isValid, value));
                                },
                                error: AppLocalizations.of(context)!.enter_valid_fullname,
                                validator: (value) {
                                  var name = value.split(' ');
                                  if (name.length == 2) {
                                    if (name[0].length >= 3 &&
                                        name[1].length >= 3) {
                                      return true;
                                    }
                                  }
                                  return false;
                                },
                              )),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            width: size.width * 0.9,
                            child: EmailFieldWithValidator(
                                hintText: AppLocalizations.of(context)!.email,
                                validate: (value, isValid) {
                                  BlocProvider.of<RegisterBloc>(context)
                                      .add(EmailChangedEvent(isValid, value));
                                }),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            width: size.width * 0.9,
                            child: PasswordFieldWithValidator(
                              hintText: AppLocalizations.of(context)!.password,
                              validate: (value, isValid) {
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(PasswordChangedEvent(isValid, value));
                              },
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 30,
                                ),
                                Checkbox(
                                    value: isAccepted,
                                    onChanged: (value) {
                                      BlocProvider.of<RegisterBloc>(context)
                                          .add(AcceptTerms(value!));
                                      setState(() {
                                        isAccepted = value;
                                      });
                                    }),
                                Row(
                                  children: [
                                    Text(AppLocalizations.of(context)!.i_agree),
                                    SizedBox(
                                      height: 40,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .terms_and_conditions),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: submitBtn,
                          ),
                          const SizedBox(height: 15,)
                        ],
                      ),
                    ),
                  ),
                  isloading
                      ? Container(
                          child: const Center(
                              child: SizedBox(child: LoadingIndicator())),
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
