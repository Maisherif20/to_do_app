import 'package:flutter/material.dart';
import 'package:untitled8/ui/myThemeData.dart';

class Dialogs {
  static void showLoadingDialogs(BuildContext context, String massege,
      {bool isbarrierDismissible = true}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(
                    color: lightPrimaryColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(massege)
                ],
              ),
            ),
        barrierDismissible: isbarrierDismissible);
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMassege(BuildContext context, String massege,
      {bool isbarrierDismissible = true,
      String? postiveActionTitle,
      String? negativeActionTitle,
      VoidCallback? postiveAction,
      VoidCallback? negativeAction}) {
    List<Widget> actionsList = [];
    if (postiveActionTitle != null) {
      actionsList.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            postiveAction?.call();
          },
          child: Text(postiveActionTitle) , style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.blue)),));
    }
    if (negativeActionTitle != null) {
      actionsList.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negativeAction?.call();
          },
          child: Text(negativeActionTitle) , style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.blue)),));
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          massege,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        actions: actionsList,
      ),
      barrierDismissible: isbarrierDismissible,
    );
  }
}
