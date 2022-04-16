import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../routes/routes.dart';
import 'state.dart';
import '../../components/basic/dialoges.dart';
import '../../components/basic/loading_indicator.dart';
import '../../components/basic/rounded_button.dart';
import '../../components/input_validators/email_field_validator.dart';
import '../profile_repository.dart';
import 'forget_password_bloc.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  String email = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = 500;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forgetPass),
      ),
      body: BlocProvider<ForgetPasswordCubit>(
        create: (context) => ForgetPasswordCubit('',ProfileRepository()),
        child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            if (state is SuccessState) {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.verifyForgetPassword, arguments: email);
            }
            if (state is FailState) {
              showInfoDialog(
                  context, '', AppLocalizations.of(context)!.success,
                  onPress: () {
                    Navigator.pop(context);
                  },barrierDismissible: true);
            }
          },
          builder: (context, state) {
            bool isLoading = false;
            if (state is LoadingState) {
              isLoading = true;
            } else if (state is SuccessState) {
              isLoading = false;
            } else if (state is FailState) {
              isLoading = false;
            }

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Container(

                    child: Column(
                      children: <Widget>[
                        SizedBox(height: size.height * 0.06),
                        Container(
                          constraints: BoxConstraints(maxWidth: maxWidth,),
                          width: size.width * 0.9,
                          child: EmailFieldWithValidator(
                              hintText: AppLocalizations.of(context)!.email,
                              validate: (value, isValid) {
                                email = value;
                                context.read<ForgetPasswordCubit>().email = value;
                              }),
                        ),
                        RoundedButton(
                          text: AppLocalizations.of(context)!.send,
                          press: () =>
                              context.read<ForgetPasswordCubit>().forgetPassword(),
                        ),
                        SizedBox(height: size.height * 0.03),
                      ],
                    ),
                  ),
                ),
                isLoading
                    ? Container(
                  child: const Center(child: SizedBox(child: LoadingIndicator())),
                  decoration: const BoxDecoration(color: Color(0x4B575757)),
                )
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}
