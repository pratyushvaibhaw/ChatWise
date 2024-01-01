import 'package:chatwise/pages/group_info_page.dart';
import 'package:chatwise/providers/chat_provider.dart';
import 'package:chatwise/providers/string_provider.dart';
import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:chatwise/services/database_service.dart';
import 'package:chatwise/widgets/message_tile.dart';
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
  final messageController = TextEditingController();

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
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: oranget2,
      appBar: appbar(context, stringProvider),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 5),
          chatMessages(),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: oranget1,
              height: 80,
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: white,
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Consumer<ChatProvider>(
                          builder: (context, value, child) {
                        return TextFormField(
                          maxLines: 10,
                          style: googleaBeeZee(bluet2, 12, FontWeight.w500,
                              spacing: .5),
                          decoration: InputDecoration(
                              suffixIconColor: bluet2,
                              suffixIcon: GestureDetector(
                                child: const Icon(Icons.send_rounded),
                                onTap: () {
                                  if (value.messageController.text.isNotEmpty) {
                                    sendMessages();
                                    chatProvider.updateMessageController();
                                  }
                                },
                              ),
                              hintText: 'message...',
                              hintStyle: googleaBeeZee(
                                  grey, 13, FontWeight.w200, spacing: 1),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: white),
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: white),
                                  borderRadius: BorderRadius.circular(16)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: white))),
                          controller: value.messageController,
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
        stream: chat,
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast),
                  itemCount: snapshot.data.docs!.length,
                  itemBuilder: ((context, index) {
                    var data = snapshot.data!.docs[index];
                    return MessageTile(
                        message: data['message'],
                        sender: data['sender'],
                        sentByMe: widget.userName == data['sender']);
                  })),
            );
          } else {
            Future.delayed(const Duration(milliseconds: 5), () {
              setState(() {});
            });
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Loading messages ...',
                  style: googleaBeeZee(white, 22, FontWeight.bold, spacing: 1),
                ),
                const SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(
                  color: bluet2,
                ),
              ],
            ));
          }
        }));
  }

  sendMessages() {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    Map<String, dynamic> chatMessages = {
      'message': chatProvider.messageController.text,
      'sender': widget.userName,
      'time': DateTime.now().millisecondsSinceEpoch
    };
    DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .sendMessage(widget.groupId, chatMessages);
  }

  AppBar appbar(BuildContext context, StringProvider stringProvider) {
    return AppBar(
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
    );
  }
}
