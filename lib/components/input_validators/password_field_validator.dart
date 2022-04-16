import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../basic/rounded_password_filed.dart';
import 'bloc/validate_password.dart';
import 'bloc/validate_state.dart';

class PasswordFieldWithValidator extends StatefulWidget {
  final Function validate;
  String? text;
  late TextEditingController _textEditingController;

  String? hintText;

  PasswordFieldWithValidator(
      {Key? key, required this.hintText, this.text,required this.validate}) : super(key: key) {
    _textEditingController = TextEditingController();
    if (text != null) _textEditingController.text = text!;
  }

  @override
  State<PasswordFieldWithValidator> createState() => _PasswordFieldWithValidatorState();
}

class _PasswordFieldWithValidatorState extends State<PasswordFieldWithValidator> {
  String? error;
  String password = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ValidatePasswordBloc>(
      create: (context) => ValidatePasswordBloc()
        ..add(ValidateChangedEvent('', widget.validate)),
      child: BlocBuilder<ValidatePasswordBloc, ValidateState>(
        builder: (context, state) {
          if (state is ValidateErrorState) {
            String error = AppLocalizations.of(context)!.password_not_valid;
            return RoundedPasswordField(
              hintText: widget.hintText!,
              error: error,
              onChanged: (value) {
                password = value;
                BlocProvider.of<ValidatePasswordBloc>(context)
                    .add(ValidateChangedEvent(value, widget.validate));
              },
            );
          }
          return RoundedPasswordField(
            hintText: widget.hintText!,
            onChanged: (value) {
              password = value;
              BlocProvider.of<ValidatePasswordBloc>(context)
                  .add(ValidateChangedEvent(value, widget.validate));
            },
          );
        },
      ),
    );
  }
}
