import 'package:chatwise/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastMessage(String mess) {
  Fluttertoast.showToast(
      msg: mess,
      textColor: bluet2,
      backgroundColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT);
}

fieldFocusChange(BuildContext context, FocusNode current, FocusNode next) {
  current.unfocus();
  FocusScope.of(context).requestFocus(
      next); // this login can be used to change the focus on any new field
}

showSnackBar(BuildContext context, String msg, Color color) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(backgroundColor: color, content: Center(child: Text(msg))),
  );
}

void nextPage(BuildContext context, String pagename) {
  if (pagename == 'login' || pagename == 'signup' || pagename == 'home') {
    Navigator.pushReplacementNamed(context, pagename);
  } else {
    Navigator.pushNamed(context, pagename);
  }
}
