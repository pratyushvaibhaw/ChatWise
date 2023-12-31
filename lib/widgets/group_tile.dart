import 'package:chatwise/pages/chat_page.dart';
import 'package:chatwise/providers/string_provider.dart';
import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:chatwise/services/database_service.dart';
import 'package:chatwise/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupTile extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  const GroupTile(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.userName});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  String getName(String s) {
    return s.substring(s.indexOf('_') + 1);
  }

  groupIconString(String s) {
    return (s.substring(0, 1) +
            s.substring(s.indexOf(' ') + 1, s.indexOf(' ') + 2))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    getGroupAdmin();
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                    userName: widget.userName,
                    groupId: widget.groupId,
                    groupName: widget.groupName)));
      },
      shape: RoundedRectangleBorder(
        side: BorderSide(color: white),
        borderRadius: BorderRadius.circular(12),
      ),
      tileColor: oranget2,
      leading: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 2.5,
        child: CircleAvatar(
          maxRadius: 20,
          backgroundColor: oranget1,
          child: Center(
              child: Text(
            groupIconString(widget.groupName),
            
            style: googleaBeeZee(white, 16, FontWeight.bold),
          )),
        ),
      ),
      title: Text(
        widget.groupName,
        style: googleaBeeZee(bluet2, 15, FontWeight.w400, spacing: 0),
      ),
    );
  }

  getGroupAdmin() {
    final stringProvider = Provider.of<StringProvider>(context);
    DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupAdmin(widget.groupId)
        .then((value) {
      stringProvider.setAdmin(value);
    });
  }
}
