import 'package:chatwise/services/auths/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('home'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _authService.signout();
      }),
    );
  }
}
