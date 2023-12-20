import 'dart:async';
import 'package:chatwise/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:chatwise/services/auths/user_session.dart';

class SplashService {
  bool _isSignedIn = false;
  getUserLoggedInStatus(BuildContext context) async {
    await UserSession.getLoggedInStatus().then((value) {
      if (value != null) {
        _isSignedIn = value;
      }
    });
    Timer(const Duration(seconds: 3), () {
      if (_isSignedIn) {
        nextPage(context, 'home');
      } else {
        nextPage(context, 'login');
      }
    });
  }
}
