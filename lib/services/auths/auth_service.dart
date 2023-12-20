import 'package:chatwise/providers/loading_provider.dart';
import 'package:chatwise/services/auths/user_session.dart';
import 'package:chatwise/services/database_service.dart';
import 'package:chatwise/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //login
  Future loginUserWithEmailandPassword(
      context, String email, String password) async {
    try {
    await  _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      final loadingProvider =
          Provider.of<LoadingProvider>(context, listen: false);
      loadingProvider.setLoading(false);
      debugPrint(e.toString());
      showSnackBar(context, e.toString(), Colors.red);
    }
  }

  //regiester
  Future regiesterUserWithEmailandPassword(
      context, String fullName, String email, String password) async {
    try {
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      await DataBaseService(uid: user.uid)
          .savingUserDate(fullName, email, user.photoURL ?? '');
      return true;
    } on FirebaseAuthException catch (e) {
      final loadingProvider =
          Provider.of<LoadingProvider>(context, listen: false);
      loadingProvider.setLoading(false);
      debugPrint(e.toString());
      showSnackBar(context, e.toString(), Colors.red);
    }
  }

  //signout
  Future signout() async {
    try {
      //deleting the user session
      await UserSession.saveUserLoggedInStatus(false);
      await UserSession.saveUserEmail('');
      await UserSession.saveUserName('');
      await _firebaseAuth.signOut();
      toastMessage('Signed Out Successfully');
    } catch (e) {
      toastMessage(e.toString());
    }
  }
}
