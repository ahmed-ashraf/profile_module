import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../basic/rounded_input_field.dart';
import 'bloc/validate_email.dart';
import 'bloc/validate_error.dart';
import 'bloc/validate_state.dart';

class EmailFieldWithValidator extends StatefulWidget {
  final Function validate;
  String? text;
  late TextEditingController _textEditingController;

  String? hintText;
  EmailFieldWithValidator(
      {Key? key,required this.hintText,
        this.text,required this.validate}) : super(key: key) {
    _textEditingController = TextEditingController();
    if (text != null) _textEditingController.text = text!;
  }

  @override
  State<EmailFieldWithValidator> createState() => _EmailFieldWithValidatorState();
}

class _EmailFieldWithValidatorState extends State<EmailFieldWithValidator> {
  String? error;
  String email = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ValidateMailBloc>(
      create: (context) =>
          ValidateMailBloc()..add(ValidateChangedEvent('', widget.validate)),
      child: BlocBuilder<ValidateMailBloc, ValidateState>(
        builder: (context, state) {
          if (state is ValidateErrorState) {
            String error = state.error == ValidateError.isRegistered
                ? AppLocalizations.of(context)!.email_registered_error
                : AppLocalizations.of(context)!.email_not_valid;
            return RoundedInputField(
              text: widget.text,
              hintText: widget.hintText!,
              error: error,
              onChanged: (value) {
                email = value;
                BlocProvider.of<ValidateMailBloc>(context)
                    .add(ValidateChangedEvent(value, widget.validate));
              },
            );
          }
          return RoundedInputField(
            text: widget.text,
            hintText: widget.hintText!,
            onChanged: (value) {
              email = value;
              BlocProvider.of<ValidateMailBloc>(context)
                  .add(ValidateChangedEvent(value, widget.validate));
            },
          );
        },
      ),
    );
  }
}
