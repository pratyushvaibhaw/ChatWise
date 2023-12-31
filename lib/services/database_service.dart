import 'package:chatwise/providers/loading_provider.dart';
import 'package:chatwise/providers/string_provider.dart';
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
      FirebaseFirestore.instance.collection('groups');

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
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
      final loadingProvider =
          Provider.of<LoadingProvider>(context, listen: false);
      loadingProvider.setLoading(false);
    }
  }

  //fetching groups user has joined
  getUserGroup() async {
    return userCollection.doc(uid).snapshots();
  }

  //creating  a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupdocumentReference = await groupCollection.add({
      'groupName': groupName,
      'groupIcon': '',
      'admin': '${id}_$userName',
      'members': [],
      'groupId': '',
    });
    //for updating members of the group
    await groupdocumentReference.update({
      'members': FieldValue.arrayUnion(['${uid}_$userName']),
      'groupId': groupdocumentReference.id
    });
    //for updating the group at user's end
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      'groups':
          FieldValue.arrayUnion(['${groupdocumentReference.id}_$groupName'])
    });
  }

//getting group admin
  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'].toString();
  }

  //getting chat
  getChat(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection('chat_threads')
        .orderBy('time')
        .snapshots();
  }

//fetching all members
  getGroupMembers(String groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  //searh group by Name
  searchGroup(String groupName) {
    return groupCollection.where('groupName', isEqualTo: groupName).get();
  }

  //checking user available in group or not
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    return groups.contains('${groupId}_$groupName');
  }

  //group exit
  Future exitGroup(String groupId, String userName, String groupName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains('${groupId}_$groupName')) {
      await userDocumentReference.update({
        'groups': FieldValue.arrayRemove(['${groupId}_$groupName'])
      });
      await groupDocumentReference.update({
        'members': FieldValue.arrayRemove(['${uid}_$userName'])
      });
    }
  }

  //group join
  Future groupJoin(String groupId, String userName, String groupName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    if (!groups.contains('${groupId}_$groupName')) {
      await userDocumentReference.update({
        'groups': FieldValue.arrayUnion(['${groupId}_$groupName'])
      });
      await groupDocumentReference.update({
        'members': FieldValue.arrayUnion(['${uid}_$userName'])
      });
    }
  }
}
