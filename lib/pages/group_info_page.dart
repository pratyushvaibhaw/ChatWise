import 'package:chatwise/providers/string_provider.dart';
import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:chatwise/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupInfoPage extends StatefulWidget {
  final String groupName;
  final String groupId;
  final String adminName;
  const GroupInfoPage(
      {super.key,
      required this.groupName,
      required this.groupId,
      required this.adminName});

  @override
  State<GroupInfoPage> createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends State<GroupInfoPage> {
  Stream? members;
  @override
  void initState() {
    super.initState();
    getMembers();
  }

  nameIconString(String s) {
    return (s.substring(s.indexOf('_') + 1, s.indexOf('_') + 2)).toUpperCase();
  }

  String getGroupNameIcon(String s) {
    return (s.substring(0, 1) +
            s.substring(s.indexOf(' ') + 1, s.indexOf(' ') + 2))
        .toUpperCase();
  }

  String getGroupAdmin(String s) {
    return s.substring(s.indexOf('_') + 1);
  }

  getMembers() async {
    DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(widget.groupId)
        .then((value) {
      members = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: memberList(),
    );
  }

  memberList() {
    final stringProvider = Provider.of<StringProvider>(context);
    return StreamBuilder(
        stream: members,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['members'] != null &&
                snapshot.data['members'] != 0) {
              var memberdata = snapshot.data['members'];
              return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.exit_to_app_sharp)),
                        )
                      ],
                      title: CircleAvatar(
                          backgroundColor: bluet2,
                          child: Text(
                            getGroupNameIcon(
                              widget.groupName,
                            ),
                            style: googleaBeeZee(white, 18, FontWeight.w500,
                                spacing: 1),
                          )),
                      flexibleSpace: FlexibleSpaceBar(
                        expandedTitleScale: 1.5,
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                              child: Text(
                                widget.groupName,
                                style: googleaBeeZee(white, 20, FontWeight.bold,
                                    spacing: 1),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: const EdgeInsets.only(top: 2, left: 5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12)),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '${getGroupAdmin(stringProvider.admin)} (admin)',
                                      style: googleaBeeZee(
                                          bluet2, 8, FontWeight.bold,
                                          spacing: 0),
                                    ),
                                    Text(
                                      '${memberdata.length} members',
                                      style: googleaBeeZee(
                                          bluet2, 8, FontWeight.bold,
                                          spacing: 0),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      expandedHeight: 190,
                      floating: true,
                      pinned: true,
                      snap: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      toolbarHeight: 100,
                      leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                    ),
                    SliverList.builder(
                        itemCount: memberdata.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 75,
                            margin: const EdgeInsets.only(top: 1, bottom: 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 2),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              tileColor: oranget2,
                              leading: Material(
                                borderRadius: BorderRadius.circular(30),
                                elevation: 2.5,
                                child: CircleAvatar(
                                  maxRadius: 20,
                                  backgroundColor: white,
                                  child: Center(
                                      child: Text(
                                    nameIconString(memberdata[index]),
                                    style: googleaBeeZee(
                                        bluet2, 16, FontWeight.bold),
                                  )),
                                ),
                              ),
                              title: Text(
                                getGroupAdmin(
                                  memberdata[index],
                                ),
                                style: googleaBeeZee(
                                    bluet2, 18, FontWeight.w400,
                                    spacing: 1),
                              ),
                            ),
                          );
                        })
                  ]);
            } else {
              return const Center(
                child: Text('EMPTY GROUP '),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: oranget1,
              ),
            );
          }
        });
  }
}
