// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:chatwise/providers/color_provider.dart';
import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:chatwise/services/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    SplashService().getUserLoggedInStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context, listen: false);
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      colorProvider.setNum();
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 75,
            ),
            Image.asset(
              'assets/images/send.png',
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'ChatWise',
              style: googleaBeeZee(bluet2, 40, FontWeight.w800,
                  sh: const Shadow(
                      blurRadius: 10,
                      color: Color.fromARGB(255, 163, 163, 163),
                      offset: Offset(5, 0))),
            ),
            const SizedBox(
              height: 30,
            ),
          const Round_Boxex()
          ],
        ),
      ),
    );
  }
}

class Round_Boxex extends StatelessWidget {
  const Round_Boxex({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorProvider>(builder: (context, value, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1.5,
                    color: (value.num == 0) ? oranget1 : Colors.transparent),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5, 0),
                    blurRadius: 5,
                  )
                ],
                color: white,
                shape: BoxShape.circle),
            child: Icon(
              Icons.chat_bubble_outline_rounded,
              color: bluet2,
            ),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1.5,
                    color: (value.num == 1) ? oranget1 : Colors.transparent),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5, 0),
                    blurRadius: 5,
                  )
                ],
                color: white,
                shape: BoxShape.circle),
            child: Icon(
              Icons.group_outlined,
              color: bluet2,
            ),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1.5,
                    color: (value.num == 2) ? oranget1 : Colors.transparent),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5, 0),
                    blurRadius: 5,
                  )
                ],
                color: white,
                shape: BoxShape.circle),
            child: Icon(
              Icons.camera,
              color: bluet2,
            ),
          ),
        ],
      );
    });
  }
}
