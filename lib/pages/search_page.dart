import 'package:chatwise/pages/chat_page.dart';
import 'package:chatwise/providers/string_provider.dart';
import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:chatwise/services/database_service.dart';
import 'package:chatwise/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  bool joinStatus = false;
  QuerySnapshot? searchSnapshot;
  String getGroupIcon(String s) {
    return (s.substring(0, 1) +
            s.substring(s.indexOf(' ') + 1, s.indexOf(' ') + 2))
        .toUpperCase();
  }

  String getAdminName(String s) {
    return s.substring(s.indexOf('_') + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        toolbarHeight: 120,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 30,
          ),
        ),
        title: Container(
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(12)),
            width: 300,
            child: TextFormField(
              controller: _searchController,
              onFieldSubmitted: (_) {
                if (_searchController.text.isNotEmpty) {
                  debugPrint(_searchController.text);
                  searchGroup();
                }
              },
              style: googleaBeeZee(bluet2, 12, FontWeight.bold, spacing: 1),
              // textAlign: TextAlign.center,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.search),
                  fillColor: Colors.white,
                  focusColor: white,
                  hintText: 'search  groups...'),
            )),
      ),
      body: groupList(),
    );
  }

  searchGroup() async {
    await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .searchGroup(_searchController.text)
        .then((snapshots) {
      searchSnapshot = snapshots;
      setState(() {});
    });
  }

  checkJoinStatus(var data) async {
    final stringProvider = Provider.of<StringProvider>(context);
    joinStatus = await DataBaseService(
            uid: FirebaseAuth.instance.currentUser!.uid)
        .isUserJoined(data['groupName'], data['groupId'], stringProvider.name);
  }

  groupList() {
    final stringProvider = Provider.of<StringProvider>(context);
    return ListView.builder(
        itemCount: (searchSnapshot != null) ? searchSnapshot!.docs.length : 0,
        itemBuilder: ((context, index) {
          var data = searchSnapshot!.docs[index];
          checkJoinStatus(data);
          return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                border: Border.all(color: oranget1, width: 2),
                color: oranget2,
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(10),
            height: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                //icon
                Text(
                  getAdminName(
                    data['groupName'],
                  ),
                  style: googleaBeeZee(bluet2, 20, FontWeight.w900, spacing: 1),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(100),
                      child: CircleAvatar(
                        backgroundColor: white,
                        minRadius: 50,
                        maxRadius: 75,
                        child: Text(
                          getGroupIcon(data['groupName']),
                          style: googleaBeeZee(bluet2, 50, FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // details
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!joinStatus) {
                                DataBaseService(
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .groupJoin(data['groupId'],
                                        stringProvider.name, data['groupName']);
                                showSnackBar(context, 'Joined Successfully !!',
                                    oranget1);
                                setState(() {});
                              }
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => ChatPage(
                                            userName: stringProvider.name,
                                            groupId: data['groupId'],
                                            groupName: data['groupName']))));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    (joinStatus) ? oranget1 : white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            child: (!joinStatus)
                                ? Text(
                                    'Join',
                                    style: googleaBeeZee(
                                        oranget1, 20, FontWeight.bold,
                                        spacing: 1),
                                  )
                                : Text(
                                    'Joined',
                                    style: googleaBeeZee(
                                        white, 15, FontWeight.bold,
                                        spacing: 1),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          getAdminName('${data['members'].length} Members'),
                          style: googleaBeeZee(bluet2, 12, FontWeight.w300,
                              spacing: 0),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          getAdminName(data['admin'] + ' (admin)'),
                          style: googleaBeeZee(bluet2, 12, FontWeight.w300,
                              spacing: 0),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        }));
  }
}
