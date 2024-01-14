import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'colors/colors.dart';

showLoading(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
              child: LoadingAnimationWidget.inkDrop(
            color: primaryColor,
            size: 80,
          ))));
}

hideLoading(BuildContext context) {
  Navigator.pop(context);
}

showMessage(BuildContext context, String message, String posBtn) {
  showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: AlertDialog(
            titlePadding: EdgeInsets.all(15),
            backgroundColor: Colors.white,
            title: Center(child: Text(textAlign: TextAlign.center, message)),
          ),
        );
      });
}

showLoginMessage(
  BuildContext context,
  String message,
) {
  showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: AlertDialog(
            titlePadding: EdgeInsets.all(15),
            backgroundColor: Colors.white,
            title: Center(child: Text(textAlign: TextAlign.center, message)),
          ),
        );
      });
}
