import 'package:flutter/material.dart';

import '../../storage/theme_colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback? press;
  final Color color, textColor;
  final double widthPercent;
  Widget? icon;
  BorderSide? borderSide;

  RoundedButton(
      {required this.text,
      this.press,
      this.color = ThemeColors.primaryColorDark,
      this.textColor = Colors.white,
      this.widthPercent = 0.8,
      this.icon,
      this.borderSide});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // decoration: BoxDecoration(
      //   shape: BoxShape.rectangle,
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black38,
      //       blurRadius: 4.0,
      //       spreadRadius: 2.0,
      //     )
      //   ],
      // ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      width: size.width * widthPercent,
      height: 50,
      child: TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: borderSide ?? BorderSide.none))),
        onPressed: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null ? icon! : Container(),
            SizedBox(
              width: icon!=null?20:0,
            ),
            Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
