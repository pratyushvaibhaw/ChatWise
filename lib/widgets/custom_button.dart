// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/dimensions.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onTap;
  const CustomButton({
    Key? key,
    required this.text,
    required this.isLoading,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: oranget1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(br12)),
          elevation: 2,
        ),
        onPressed: onTap,
        child: (!isLoading)
            ? Text(
                text,
                style: googleaBeeZee(white, 15, FontWeight.bold),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: white,
                ),
              ));
  }
}
