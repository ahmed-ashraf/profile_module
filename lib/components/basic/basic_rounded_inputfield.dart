import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../storage/theme_colors.dart';


class BasicRoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  String? svgIcon;
  final ValueChanged<String> onChanged;
  String? text;
  TextInputType keyboardType;
  late TextEditingController _textEditingController;
  VoidCallback? onTap;
  String? error;

  BasicRoundedInputField(
      {Key? key,
        required this.hintText,
        this.icon,
        this.svgIcon,
        required this.onChanged,
        this.text,
        this.keyboardType = TextInputType.text,
        this.error,
        this.onTap})
      : super(key: key) {
    _textEditingController = TextEditingController();
    if (text != null) {
      _textEditingController.text = text!;
      _textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: _textEditingController.text.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      keyboardType: keyboardType,
      controller: text != null ? _textEditingController : null,
      onChanged: onChanged,
      decoration: InputDecoration(
          prefixIcon: icon != null
              ? Icon(
            icon,
            color: ThemeColors.primaryColorDark2,
          )
              : svgIcon != null
              ? SizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset(svgIcon!))
              : null,
          filled: true,
          fillColor: ThemeColors.backgroundTextFieldColor,
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: ThemeColors.primaryColorDark),
          ),
          errorText: error),
    );
  }
}
