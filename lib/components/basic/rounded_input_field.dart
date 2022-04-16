import 'package:flutter/material.dart';

import 'basic_rounded_inputfield.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  String? svgIcon;
  final ValueChanged<String> onChanged;
  String? text;
  TextInputType keyboardType;
  VoidCallback? onTap;
  String? error;

  RoundedInputField(
      {Key? key,
      required this.hintText,
      this.icon,
      this.svgIcon,
      required this.onChanged,
      this.text,
      this.keyboardType = TextInputType.text,
      this.error,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hintText),
          const SizedBox(height: 13,),
          BasicRoundedInputField(
            hintText: hintText,
            onChanged: onChanged,
            icon: icon,
            svgIcon: svgIcon,
            text: text,
            onTap: onTap,
            error: error,
            keyboardType: keyboardType,
          ),
        ],
      ),
    );
  }
}
