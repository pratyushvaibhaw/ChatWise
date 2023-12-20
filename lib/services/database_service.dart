import 'package:chatwise/providers/loading_provider.dart';
import 'package:chatwise/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataBaseService {
  final String? uid;

  DataBaseService({required this.uid});
//there are two refernces for user and one for the groups they are joined in
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('group');

  Future savingUserDate(String fullname, String email, String photourl) async {
    return userCollection.doc(uid).set({
      'fullName': fullname,
      'email': email,
      'uid': uid,
      'photo': photourl,
      'groups': []
    });
  }

  //fetching userdata
  Future gettingUserData(String email, context) async {
    try {
      QuerySnapshot snapshot =
          await userCollection.where('email', isEqualTo: email).get();
      return snapshot;
    }  catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
      final loadingProvider =
          Provider.of<LoadingProvider>(context, listen: false);
      loadingProvider.setLoading(false);
    }
  }
}
