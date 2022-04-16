import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../basic/rounded_input_field.dart';
import 'bloc/validate_state.dart';
import 'bloc/validate_text.dart';

class TextFieldWithValidator extends StatefulWidget {
  final Function validate;
  String? text;
  String error;
  IconData? icon;
  String? svgIcon;
  late TextEditingController _textEditingController;
  Function(String)? validator;

  String? hintText;

  TextFieldWithValidator(
      {Key? key,
      required this.hintText,
      this.text,
      required this.validate,
      required this.error,
      this.icon,
      this.svgIcon,
      this.validator})
      : super(key: key) {
    _textEditingController = TextEditingController();
    if (text != null) _textEditingController.text = text!;
  }

  @override
  State<TextFieldWithValidator> createState() => _TextFieldWithValidatorState();
}

class _TextFieldWithValidatorState extends State<TextFieldWithValidator> {
  String? error;
  String text = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ValidateTextBloc>(
      create: (context) => ValidateTextBloc()
        ..add(ValidateChangedEvent('', widget.validate,
            validator: widget.validator)),
      child: BlocBuilder<ValidateTextBloc, ValidateState>(
        builder: (context, state) {
          if (state is ValidateErrorState) {
            String error = widget.error;
            return RoundedInputField(
              text: widget.text,
              icon: widget.icon,
              hintText: widget.hintText!,
              svgIcon: widget.svgIcon,
              error: error,
              onChanged: (value) {
                text = value;
                BlocProvider.of<ValidateTextBloc>(context).add(
                    ValidateChangedEvent(value, widget.validate,
                        validator: widget.validator));
              },
            );
          }
          return RoundedInputField(
            text: widget.text,
            icon: widget.icon,
            svgIcon: widget.svgIcon,
            hintText: widget.hintText!,
            onChanged: (value) {
              text = value;
              BlocProvider.of<ValidateTextBloc>(context).add(
                  ValidateChangedEvent(value, widget.validate,
                      validator: widget.validator));
            },
          );
        },
      ),
    );
  }
}
