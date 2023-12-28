import 'package:chatwise/providers/string_provider.dart';
import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/dimensions.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:chatwise/services/auths/auth_service.dart';
import 'package:chatwise/utils/utils.dart';
import 'package:chatwise/widgets/log_out_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({
    super.key,
    required AuthService authService,
  }) : _authService = authService;

  final AuthService _authService;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: ten * .2,
      shadowColor: oranget1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(twelve),
          side: BorderSide(color: Colors.grey.shade300, width: ten * .8)),
      child: Padding(
        padding: EdgeInsets.only(left: twelve * 1.5, top: twelve),
        child: ListView(
          children: [
            Icon(
              Icons.account_circle_rounded,
              size: twelve * 15,
            ),
            SizedBox(
              height: ten * 1.5,
            ),
            Consumer<StringProvider>(builder: (context, value, child) {
              return Text(
                value.name,
                textAlign: TextAlign.center,
                style: googleaBeeZee(bluet2, 15, FontWeight.w400, spacing: 1),
              );
            }),
            SizedBox(
              height: ten * 1.5,
            ),
            Divider(
              thickness: 1.5,
              color: oranget1,
            ),
            SizedBox(
              height: ten * 1.5,
            ),
            ListTile(
              onTap: () {
                nextPage(context, 'profile');
              },
              tileColor: oranget2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(twelve)),
              leading: Icon(
                Icons.person,
                color: oranget1,
              ),
              title: Text(
                'Profile',
                style: googleaBeeZee(bluet2, 15, FontWeight.w400, spacing: 1),
              ),
            ),
            SizedBox(
              height: ten * .6,
            ),
            ListTile(
              tileColor: oranget2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(twelve)),
              leading: Icon(
                Icons.groups_rounded,
                color: oranget1,
              ),
              title: Text(
                'Groups',
                style: googleaBeeZee(bluet2, 15, FontWeight.w400, spacing: 1),
              ),
            ),
            SizedBox(
              height: ten * .6,
            ),
            ListTile(
              tileColor: oranget2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(twelve)),
              onTap: () {
                logOutDialog(context, () {
                  _authService.signout().then((value) {
                    nextPage(context, 'login');
                  });
                });
              },
              leading: Icon(
                Icons.logout_rounded,
                color: oranget1,
              ),
              title: Text(
                'Sign Out',
                style: googleaBeeZee(bluet2, 15, FontWeight.w400, spacing: 1),
              ),
            ),
            SizedBox(
              height: ten * .6,
            ),
            ListTile(
              tileColor: oranget2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(twelve)),
              onTap: () {},
              leading: Icon(
                Icons.support_agent_rounded,
                color: oranget1,
              ),
              title: Text(
                'Support',
                style: googleaBeeZee(bluet2, 15, FontWeight.w400, spacing: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
