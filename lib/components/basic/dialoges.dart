import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../storage/theme_colors.dart';

Future showSuccessInFlushBar(BuildContext context, String title, String content) {
  return Flushbar(
    icon: const Icon(
      Icons.done,
      color: Colors.green,
    ),
    leftBarIndicatorColor: Colors.green,
    flushbarPosition: FlushbarPosition.TOP,
    title: title,
    titleColor: Colors.white,
    message: content,
    isDismissible: true,
    duration: const Duration(seconds: 3),
  ).show(context);
}

Future showErrorInFlushBar(BuildContext context, String title, String content) {
  return Flushbar(
    icon: const Icon(
      Icons.error_outline,
      color: Colors.red,
    ),
    leftBarIndicatorColor: Colors.red,
    flushbarPosition: FlushbarPosition.TOP,
    title: title,
    titleColor: Colors.white,
    message: content,
    isDismissible: true,
    duration: const Duration(seconds: 3),
  ).show(context);
}

void showAlertDialog(BuildContext context, String msg,
    {bool barrierDismissible = true, VoidCallback? onPress}) {
  showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: ThemeColors.white,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      msg,
                      maxLines: 11,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (onPress != null) onPress.call();
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      child: Material(
                          color: ThemeColors.primaryColorMid,
                          borderRadius: BorderRadius.circular(25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)!.ok,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future showInfoDialog(BuildContext context, String title, String content,
    {bool barrierDismissible = true,
    VoidCallback? onPress,
    String? acceptTitle,
    String? rejectTitle,
    VoidCallback? onReject}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      List<Widget> actionsList = [
        TextButton(
          child: Text(acceptTitle ?? AppLocalizations.of(context)!.ok),
          onPressed: () {
            Navigator.of(context).pop();
            if (onPress != null) onPress.call();
          },
        ),
      ];
      if (rejectTitle != null) {
        actionsList.add(TextButton(
          child: Text(rejectTitle),
          onPressed: () {
            Navigator.of(context).pop();
            if (onReject != null) onReject.call();
          },
        ));
      }
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actionsList,
      );
    },
  );
}
