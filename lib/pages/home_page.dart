import 'package:chatwise/providers/string_provider.dart';
import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/dimensions.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:chatwise/services/auths/auth_service.dart';
import 'package:chatwise/services/auths/user_session.dart';
import 'package:chatwise/services/database_service.dart';
import 'package:chatwise/utils/utils.dart';
import 'package:chatwise/widgets/create_group_dialog.dart';
import 'package:chatwise/widgets/group_tile.dart';
import 'package:chatwise/widgets/noGroupWidget.dart';

import 'package:chatwise/widgets/user_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();

  Stream? groups;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroup()
        .then((snapshots) {
      groups = snapshots;
    });
  }

  String getId(String s) {
    return s.substring(0, s.indexOf('_'));
  }

  String getName(String s) {
    return s.substring(s.indexOf('_') + 1);
  }

  @override
  Widget build(BuildContext context) {
    setNameEmail();
    return Scaffold(
      endDrawer: UserDrawer(authService: _authService),
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(twelve * .5)),
          actions: [
            IconButton(
                onPressed: () {
                  nextPage(context, 'search');
                },
                icon: Icon(
                  Icons.search_rounded,
                  size: twelve * 2.5,
                ))
          ],
          leading: Builder(builder: (context) {
            return IconButton(
                color: bluet2,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(
                  Icons.view_stream,
                  size: twelve * 2.5,
                ));
          }),
          toolbarHeight: twelve * 10,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: oranget1,
          title: Text(
            'ChatWise',
            style: googleaBeeZee(white, 25, FontWeight.bold),
          )),
      body: groupStream(),
      floatingActionButton: FloatingActionButton(
        elevation: 1.5,
        tooltip: 'new group',
        backgroundColor: white,
        foregroundColor: bluet2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(twelve * 1.5),
            side: BorderSide(color: oranget1, width: 1.2)),
        onPressed: () {
          createGroupDialog(
            context,
          );
        },
        child: Icon(
          Icons.group_add_rounded,
          size: twelve * 2.5,
        ),
      ),
    );
  }

  groupStream() {
    final stringProvider = Provider.of<StringProvider>(context, listen: false);

    return StreamBuilder(
        stream: groups,
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['groups'] != null &&
                snapshot.data['groups'].length != 0) {
              var data = snapshot.data['groups'];
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: ((context, index) {
                  int reverseIndex = data.length - 1 - index;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    height: 75,
                    margin: const EdgeInsets.only(top: 1, bottom: 1),
                    child: GroupTile(
                        groupId: getId(
                          data[reverseIndex].toString(),
                        ),
                        groupName: getName(data[reverseIndex].toString()),
                        userName: stringProvider.name),
                  );
                }),
                itemCount: snapshot.data['groups'].length,
              );
            } else {
              return noGroupWidget();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: oranget1,
              ),
            );
          }
        }));
  }

  setNameEmail() async {
    // this is how we can pass a value of Future <String?> to a String variable;

    final stringProvider = Provider.of<StringProvider>(context);
    await UserSession.getEmail().then((value) {
      stringProvider.setEmail(value!);
    });
    await UserSession.getName().then((value) {
      stringProvider.setName(value!);
    });
  }
}
