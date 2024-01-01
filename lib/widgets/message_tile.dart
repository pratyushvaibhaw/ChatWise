import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sentByMe;
  const MessageTile(
      {super.key,
      required this.message,
      required this.sender,
      required this.sentByMe});

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: (widget.sentByMe) ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin:
            const EdgeInsets.only(top: 2.5, bottom: 1.5, left: 10, right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: (widget.sentByMe)
                    ? const Radius.circular(16)
                    : const Radius.circular(2),
                bottomRight: (widget.sentByMe)
                    ? const Radius.circular(2)
                    : const Radius.circular(16))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.sender,
              style: googleaBeeZee(oranget1, 8, FontWeight.bold, spacing: .5),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(widget.message,
                style: googleaBeeZee(bluet2, 10, FontWeight.bold, spacing: .5))
          ],
        ),
      ),
    );
  }
}
