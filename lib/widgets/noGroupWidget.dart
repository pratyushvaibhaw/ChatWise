import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:flutter/material.dart';

noGroupWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 175,
        ),
        Icon(
          Icons.groups_3,
          color: grey,
          size: 75,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Seems like you are not in any group, \ncreate or join any group',
          style: googleaBeeZee(
            bluet2,
            15,
            FontWeight.w400,
            spacing: .5,
          ),
          textAlign: TextAlign.justify,
        )
      ],
    ),
  );
}
