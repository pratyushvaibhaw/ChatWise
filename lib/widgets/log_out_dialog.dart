import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/dimensions.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:flutter/material.dart';

logOutDialog(BuildContext context, VoidCallback yes) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 1,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: oranget1, width: 2),
              borderRadius: BorderRadius.circular(twelve * 1.5)),
          actionsPadding: EdgeInsets.all(ten),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          title: Text(
            'Sign Out',
            style: googleaBeeZee(bluet2, ten * 2, FontWeight.bold, spacing: .5),
          ),
          content: Text('Are you sure?',
              style: googleaBeeZee(bluet2, ten * 1.5, FontWeight.w400,
                  spacing: .5)),
          actions: [
            GestureDetector(
              onTap: yes,
              child: Text(
                'Yes',
                style: googleaBeeZee(bluet2, ten * 1.5, FontWeight.w300,
                    spacing: .5),
              ),
            ),
            GestureDetector(
              child: Text('Go Back',
                  style: googleaBeeZee(bluet2, ten * 1.5, FontWeight.w300,
                      spacing: .5)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        );
      });
}
