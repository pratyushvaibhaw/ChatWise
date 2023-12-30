import 'package:chatwise/pages/group_info_page.dart';
import 'package:chatwise/providers/string_provider.dart';
import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:chatwise/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const ChatPage(
      {super.key,
      required this.userName,
      required this.groupId,
      required this.groupName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chat;
  Stream? totParticipants;
  @override
  void initState() {
    super.initState();
    getChat();
  }

  groupIconString(String s) {
    return (s.substring(0, 1) +
            s.substring(s.indexOf(' ') + 1, s.indexOf(' ') + 2))
        .toUpperCase();
  }

  getChat() async {
    DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getChat(widget.groupId)
        .then((value) {
      chat = value;
    });
  }

 

  @override
  Widget build(BuildContext context) {
    final stringProvider = Provider.of<StringProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
       
        leadingWidth: 80,
        centerTitle: true,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: IconButton(
                  iconSize: 35,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: bluet2,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    groupIconString(widget.groupName),
                    style: googleaBeeZee(white, 11, FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        title: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => GroupInfoPage(
                        groupName: widget.groupName,
                        groupId: widget.groupId,
                        adminName: stringProvider.admin,
                      )))),
          child: Text(
            widget.groupName,
            style: googleaBeeZee(white, 16, FontWeight.w600, spacing: .5),
          ),
        ),
      ),
    );
  }

 
}
