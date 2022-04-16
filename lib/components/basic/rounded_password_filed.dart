import 'package:flutter/material.dart';

import 'basic_rounded_passwordfield.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  String? error;

  RoundedPasswordField(
      {required this.onChanged, this.hintText = "Password", this.error});

  @override
  _RoundedPasswordField createState() => _RoundedPasswordField();
}

class _RoundedPasswordField extends State<RoundedPasswordField> {
  _RoundedPasswordField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.hintText),
          const SizedBox(height: 13,),
          BasicRoundedPasswordField(
            hintText: widget.hintText,
            onChanged: widget.onChanged,
            error: widget.error,
          ),
        ],
      ),
    );
  }
}
