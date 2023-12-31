import 'package:chatwise/providers/loading_provider.dart';
import 'package:chatwise/providers/string_provider.dart';
import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/dimensions.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:chatwise/services/database_service.dart';
import 'package:chatwise/utils/utils.dart';
import 'package:chatwise/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

createGroupDialog(
  BuildContext context,
) {
  final gnameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
  final stringProvider = Provider.of<StringProvider>(context, listen: false);
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          child: AlertDialog(
            elevation: 1,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: oranget1, width: 2),
                borderRadius: BorderRadius.circular(twelve * 1.5)),
            actionsPadding: EdgeInsets.all(ten),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            title: Text(
              'Create group',
              style:
                  googleaBeeZee(bluet2, ten * 2, FontWeight.bold, spacing: .5),
            ),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: gnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'need a group name';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        enabled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(twelve),
                            borderSide: BorderSide(color: bluet2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(twelve),
                            borderSide: BorderSide(color: bluet2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(twelve),
                            borderSide: BorderSide(color: oranget2)),
                        hintText: 'enter a group name'),
                  )
                ],
              ),
            ),
            actions: [
              Consumer<LoadingProvider>(
                  builder: ((context, isLoading, child) => SizedBox(
                        height: 50,
                        child: CustomButton(
                            text: 'Confirm & Create',
                            isLoading: isLoading.loading,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                loadingProvider.setLoading(true);
                                debugPrint(loadingProvider.loading.toString());
                                var user = FirebaseAuth.instance.currentUser;
                                DataBaseService(uid: user!.uid)
                                    .createGroup(stringProvider.name, user.uid,
                                        gnameController.text)
                                    .then((value) {
                                  loadingProvider.setLoading(false);
                                  showSnackBar(
                                      context,
                                      '${gnameController.text} created',
                                      oranget1);
                                  Navigator.pop(context);
                                });
                              }
                            }),
                      ))),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                child: Text('Cancel',
                    style: googleaBeeZee(bluet2, ten * 1.5, FontWeight.w300,
                        spacing: .5)),
                onTap: () {
                  loadingProvider.setLoading(false);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
}
