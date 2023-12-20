import 'dart:math';

import 'package:chatwise/providers/loading_provider.dart';
import 'package:chatwise/res/colors.dart';
import 'package:chatwise/res/dimensions.dart';
import 'package:chatwise/res/textstyle.dart';
import 'package:chatwise/services/auths/auth_service.dart';
import 'package:chatwise/services/auths/user_session.dart';
import 'package:chatwise/utils/utils.dart';
import 'package:chatwise/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final ValueNotifier<bool> _obscure = ValueNotifier<bool>(true);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailfocusNode = FocusNode();
  final _passwordfocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final AuthService _authService = AuthService();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailfocusNode.dispose();
    _passwordfocusNode.dispose();
    _nameController.dispose();
    _nameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('rebuild');
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
                  //for username
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'name is required';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (value) => fieldFocusChange(
                        context, _nameFocusNode, _emailfocusNode),
                    style: googleaBeeZee(grey, twelve, FontWeight.w600,
                        spacing: 1),
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    keyboardType: TextInputType.name,
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
                        prefixIcon: const Icon(Icons.person_rounded),
                        hintText: 'full name'),
                  ),
                  SizedBox(
                    height: ten * 3,
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
                          text: 'Sign Up',
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              loadingProvider.setLoading(true);
                              regiesterUser(
                                  _nameController.text,
                                  _emailController.text,
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
                        'Already have an account? ',
                        style: googleaBeeZee(bluet2, twelve, FontWeight.w500,
                            spacing: .5),
                      ),
                      GestureDetector(
                        onTap: () {
                          nextPage(context, 'login');
                        },
                        child: Text(
                          'Sign In ',
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

  regiesterUser(String fullName, String email, String password) async {
    await _authService
        .regiesterUserWithEmailandPassword(context, fullName, email, password)
        .then((value) {
      if (value == true) {
        //saving the user session
        UserSession.saveUserLoggedInStatus(true);
        UserSession.saveUserName(fullName);
        UserSession.saveUserEmail(email);
        final loadingProvider =
            Provider.of<LoadingProvider>(context, listen: false);
        loadingProvider.setLoading(false);
        //change the page if and only if the signup is successfull
        toastMessage(email);
        nextPage(context, 'home');
      } else {}
    });
  }
}
