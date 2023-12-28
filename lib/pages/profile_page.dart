import 'package:chatwise/providers/string_provider.dart';
import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/dimensions.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            iconSize: ten * 2.5,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          backgroundColor: oranget1,
          centerTitle: true,
          title: Text(
            'Profile',
            style: googleaBeeZee(white, twelve * 2, FontWeight.bold),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: oranget2),
          padding: EdgeInsets.all(twelve),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ten * 8,
              ),
              Center(
                child: Icon(
                  Icons.account_circle_rounded,
                  size: twelve * 10,
                ),
              ),
              SizedBox(
                height: ten * 8,
              ),
              Padding(
                padding: EdgeInsets.all(ten),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Full Name',
                          style: googleaBeeZee(
                              bluet2, twelve * 1.2, FontWeight.bold,
                              spacing: .5),
                        ),
                        SizedBox(
                          width: twelve,
                        ),
                        Consumer<StringProvider>(
                            builder: (context, value, child) {
                          return Text(value.name,
                              style: googleaBeeZee(
                                  bluet2, twelve * 1.1, FontWeight.w400,
                                  spacing: 1));
                        })
                      ],
                    ),
                    SizedBox(
                      height: ten * 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email',
                          style: googleaBeeZee(
                              bluet2, twelve * 1.3, FontWeight.bold,
                              spacing: .5),
                        ),
                        SizedBox(
                          width: twelve,
                        ),
                        Consumer<StringProvider>(
                            builder: (context, value, child) {
                          return Text(
                            value.email,
                            style: googleaBeeZee(
                                bluet2, twelve * 1.1, FontWeight.w400,
                                spacing: 1),
                          );
                        })
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: twelve * 5,
                child: Divider(
                  color: grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
