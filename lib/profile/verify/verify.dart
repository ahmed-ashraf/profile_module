import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:profile_module/profile/verify/verify_bloc.dart';

import '../../components/basic/dialoges.dart';
import '../../components/basic/loading_indicator.dart';
import '../../components/basic/rounded_button.dart';
import '../../routes/routes.dart';
import '../../storage/theme_colors.dart';
import '../profile_repository.dart';
import 'event.dart';
import 'state.dart';

class VerificationArgs {
  String email;

  VerificationArgs(this.email);
}

class VerificationPage extends StatefulWidget {
  VerificationArgs args;

  VerificationPage(this.args, {Key? key}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
    super.initState();
  }

  late Timer _timer;
  int _start = 60 * 2;

  void startTimer() {
    _start = 60;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    errorController!.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<VerifyBloc>(
        create: (context) => VerifyBloc(ProfileRepository()),
        child: BlocListener<VerifyBloc, VerifyState>(
          listener: (context, state) {
            if (state is ErrorState) {
              showErrorInFlushBar(
                  context, AppLocalizations.of(context)!.error, state.error);
            } else if (state is VerifySuccessState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.home,
                (Route<dynamic> route) => false,
              );
            } else if (state is VerifyCodeResent) {
              showSuccessInFlushBar(
                  context, AppLocalizations.of(context)!.success, AppLocalizations.of(context)!.codeHasBeenResent);
            }
          },
          child: BlocBuilder<VerifyBloc, VerifyState>(
            builder: (context, state) {
              bool isloading = false;
              if (state is LoadingState) {
                isloading = state.isLoading;
                if (isloading) {
                  FocusScope.of(context).unfocus();
                }
              }

              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: ThemeColors.white,
                      child: ListView(
                        children: <Widget>[
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              AppLocalizations.of(context)!.verifyTitle,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 8),
                            child: RichText(
                              text: TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .enterSentCodeTo,
                                  children: [
                                    TextSpan(
                                        text: widget.args.email,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                  ],
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 15)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: formKey,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 30),
                                child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: PinCodeTextField(
                                    textStyle: TextStyle(),
                                    appContext: context,
                                    pastedTextStyle: TextStyle(
                                      color: Colors.green.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    length: 6,
                                    blinkWhenObscuring: true,
                                    animationType: AnimationType.fade,
                                    validator: (v) {
                                      if (v!.length < 3) {
                                        return "";
                                      } else {
                                        return null;
                                      }
                                    },
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      fieldHeight: 50,
                                      fieldWidth: 40,
                                      activeFillColor: Colors.white,
                                    ),
                                    cursorColor: Colors.black,
                                    animationDuration:
                                        const Duration(milliseconds: 300),
                                    enableActiveFill: true,
                                    errorAnimationController: errorController,
                                    controller: textEditingController,
                                    keyboardType: TextInputType.number,
                                    boxShadows: const [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        color: Colors.black12,
                                        blurRadius: 10,
                                      )
                                    ],
                                    onCompleted: (v) {
                                      print("Completed");
                                    },
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        currentText = value;
                                      });
                                    },
                                    beforeTextPaste: (text) {
                                      print("Allowing to paste $text");
                                      return true;
                                    },
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              hasError
                                  ? AppLocalizations.of(context)!
                                      .makeSureTofillAllCells
                                  : "",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.notReceiveCode,
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 15),
                              ),
                              _start <= 0
                                  ? TextButton(
                                      onPressed: () {
                                        startTimer();
                                        BlocProvider.of<VerifyBloc>(context).add(
                                            ResendEvent(widget.args.email));
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .resendCode,
                                        style: const TextStyle(
                                            color: Color(0xFF91D3B3),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ))
                                  : Text(
                                      ' $_start ${AppLocalizations.of(context)!.seconds} ',
                                      style: TextStyle(color: Colors.red),
                                    )
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          RoundedButton(
                            text: AppLocalizations.of(context)!.verify,
                            press: () {
                              formKey.currentState!.validate();
                              if (currentText.length != 6) {
                                errorController!.add(ErrorAnimationType.shake);
                                setState(() => hasError = true);
                                return;
                              }
                              BlocProvider.of<VerifyBloc>(context).add(
                                  SubmitEvent(widget.args.email, currentText));
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                  child: TextButton(
                                child:
                                    Text(AppLocalizations.of(context)!.clear),
                                onPressed: () {
                                  textEditingController.clear();
                                },
                              )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  isloading
                      ? Container(
                          child: const Center(
                              child: SizedBox(child: LoadingIndicator())),
                          decoration:
                              const BoxDecoration(color: Color(0x4B575757)),
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
