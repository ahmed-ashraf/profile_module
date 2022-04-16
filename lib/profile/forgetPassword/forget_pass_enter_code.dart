import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../components/input_validators/password_field_validator.dart';
import 'state.dart';
import '../../components/basic/dialoges.dart';
import '../../components/basic/loading_indicator.dart';
import '../../components/basic/rounded_button.dart';
import '../../components/basic/rounded_input_field.dart';
import '../profile_repository.dart';
import 'forget_password_bloc.dart';

class ForgetPassEnterCodePage extends StatefulWidget {
  String email;

  ForgetPassEnterCodePage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  _ForgetPassEnterCodePageState createState() =>
      _ForgetPassEnterCodePageState();
}

class _ForgetPassEnterCodePageState extends State<ForgetPassEnterCodePage> {
  String password='';
  String code='';

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
        title: Text(AppLocalizations.of(context)!.forget_pass),
      ),
      body: BlocProvider<ForgetPasswordCubit>(
        create: (context) => ForgetPasswordCubit(widget.email,ProfileRepository()),
        child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            if (state is SuccessState) {
              showInfoDialog(
                context,
                '',
                AppLocalizations.of(context)!.success,
                onPress: () {
                  Navigator.pop(context);
                },
                barrierDismissible: false,
              );
            }
            if (state is FailState) {
              showInfoDialog(
                context,
                '',
                state.msg,
                onPress: () {
                  Navigator.pop(context);
                },
                barrierDismissible: true,
              );
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
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: size.height * 0.03),
                          Text(
                            AppLocalizations.of(context)!.enterSentCode,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.height * 0.03),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            width: size.width * 0.9,
                            child: RoundedInputField(
                              keyboardType: TextInputType.number,
                              icon: Icons.confirmation_number_outlined,
                              hintText: AppLocalizations.of(context)!.enterSentCode,
                              onChanged: (value) {
                                code = value;
                                context.read<ForgetPasswordCubit>().code=code;
                              },
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            width: size.width * 0.9,
                            child: PasswordFieldWithValidator(
                              hintText: AppLocalizations.of(context)!.newPassword,
                              validate: (value, isValid) {
                                password = value;
                                context.read<ForgetPasswordCubit>().newPassword=password;
                              },
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            width: size.width * 0.9,
                            child: RoundedButton(
                              text: AppLocalizations.of(context)!.send,
                              press: () => context.read<ForgetPasswordCubit>().updatePassword(),
                            ),
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
