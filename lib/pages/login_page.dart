// ignore_for_file: use_build_context_synchronously

import 'package:chatwise/providers/loading_provider.dart';
import 'package:chatwise/providers/string_provider.dart';
import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/dimensions.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:chatwise/services/auths/auth_service.dart';
import 'package:chatwise/services/auths/user_session.dart';
import 'package:chatwise/services/database_service.dart';
import 'package:chatwise/utils/utils.dart';
import 'package:chatwise/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ValueNotifier<bool> _obscure = ValueNotifier<bool>(true);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailfocusNode = FocusNode();
  final _passwordfocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailfocusNode.dispose();
    _passwordfocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: pd10, vertical: pd10),
          child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: ten * 10,
                  ),
                  Text(
                    'ChatWise',
                    style: googleaBeeZee(bluet2, twelve * 3, FontWeight.bold),
                  ),
                  SizedBox(
                    height: ten * 5,
                  ),
                  Image.asset(
                    'assets/images/send.png',
                    height: ten * 14,
                  ),
                  SizedBox(
                    height: ten * 5,
                  ),
                  //for email
                  TextFormField(
                    validator: MultiValidator([
                      EmailValidator(errorText: 'enter correct email'),
                      RequiredValidator(errorText: 'email is required'),
                    ]),
                    onFieldSubmitted: (value) => fieldFocusChange(
                        context, _emailfocusNode, _passwordfocusNode),
                    style: googleaBeeZee(grey, twelve, FontWeight.w600,
                        spacing: 1),
                    controller: _emailController,
                    focusNode: _emailfocusNode,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: bluet2),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: bluet2),
                            borderRadius: BorderRadius.circular(12)),
                        prefixIconColor: oranget1,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: bluet2),
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.alternate_email_rounded),
                        hintText: 'email'),
                  ),
                  SizedBox(
                    height: ten * 3,
                  ),
                  //password
                  ValueListenableBuilder(
                      valueListenable: _obscure,
                      builder: (context, obscure, _) {
                        return TextFormField(
                          validator: MultiValidator([
                            MinLengthValidator(8,
                                errorText: 'minimum length must be 8'),
                            RequiredValidator(
                                errorText: 'password is required'),
                          ]),
                          obscureText: obscure,
                          style: googleaBeeZee(grey, twelve, FontWeight.w600,
                              spacing: 1),
                          controller: _passwordController,
                          focusNode: _passwordfocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              suffixIconColor: bluet2,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    _obscure.value = !_obscure.value;
                                  },
                                  child: (obscure)
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: bluet2),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: bluet2),
                                  borderRadius: BorderRadius.circular(12)),
                              prefixIconColor: oranget1,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: bluet2),
                                  borderRadius: BorderRadius.circular(12)),
                              prefixIcon: const Icon(Icons.abc_sharp),
                              hintText: 'password'),
                        );
                      }),
                  SizedBox(
                    height: ten * 2,
                  ),
                  SizedBox(
                    height: ten * 5,
                    width: twelve * 22,
                    child: Consumer<LoadingProvider>(
                        builder: (context, value, child) {
                      return CustomButton(
                          isLoading: value.loading,
                          text: 'Login',
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              loadingProvider.setLoading(true);
                              loginUser(_emailController.text,
                                  _passwordController.text);
                            }
                          });
                    }),
                  ),
                  SizedBox(
                    height: ten * .8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New user? ',
                        style: googleaBeeZee(bluet2, twelve, FontWeight.w500,
                            spacing: .5),
                      ),
                      GestureDetector(
                        onTap: () {
                          nextPage(context, 'signup');
                        },
                        child: Text(
                          'Sign Up ',
                          style: googleaBeeZee(grey, 12, FontWeight.w900,
                              spacing: .5),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  loginUser(String email, String password) async {
    final stringProvider = Provider.of<StringProvider>(context, listen: false);

    await _authService
        .loginUserWithEmailandPassword(context, email, password)
        .then((value) async {
      if (value == true) {
        //getting the user data ,
        QuerySnapshot snapshot =
            await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(email, context);
        //saving the user session
        UserSession.saveUserLoggedInStatus(true);
        UserSession.saveUserName(snapshot.docs[0]['fullName']);
        UserSession.saveUserEmail(email);
        stringProvider.setEmail(email);
        stringProvider.setName(snapshot.docs[0]['fullName']);
        final loadingProvider =
            Provider.of<LoadingProvider>(context, listen: false);
        loadingProvider.setLoading(false);
        toastMessage(email);
        nextPage(context, 'home');
      }
    });
  }
}
