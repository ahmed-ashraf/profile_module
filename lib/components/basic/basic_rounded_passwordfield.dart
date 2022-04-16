import 'package:flutter/material.dart';

import '../../storage/theme_colors.dart';


class BasicRoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  String? error;

  BasicRoundedPasswordField(
      {required this.onChanged, this.hintText = "Password", this.error});

  @override
  _BasicRoundedPasswordField createState() =>
      _BasicRoundedPasswordField(onChanged: onChanged, hintText: hintText);
}

class _BasicRoundedPasswordField extends State<BasicRoundedPasswordField> {
  bool _passwordVisible = false;
  final String hintText;
  final ValueChanged<String> onChanged;

  _BasicRoundedPasswordField({required this.onChanged, this.hintText = "Password"});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: !_passwordVisible,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: ThemeColors.backgroundTextFieldColor,
        errorText: widget.error,
        hintText: hintText,
        // prefixIcon: const Icon(
        //   Icons.lock,
        //   color: ThemeColors.primaryColorDark2,
        // ),
        suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xffafafaf),
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            }),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide.none),
        focusedBorder:  const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: ThemeColors.primaryColorDark),
        ),
      ),
    );
  }
}
