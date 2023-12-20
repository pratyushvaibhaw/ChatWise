import 'package:chatwise/pages/home_page.dart';
import 'package:chatwise/pages/login_page.dart';
import 'package:chatwise/pages/signup_page.dart';
import 'package:chatwise/pages/splash_page.dart';
import 'package:chatwise/providers/auth_provider.dart';
import 'package:chatwise/providers/color_provider.dart';
import 'package:chatwise/providers/loading_provider.dart';
import 'package:chatwise/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAB27ZmWU0CcmXOeFjEWKc8m3R-4AX0cfI",
          appId: "1:563170651266:android:6f7895f326c8752fbad89b",
          messagingSenderId: '563170651266',
          projectId: "chatwise-fb3b8"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ColorProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
      ],
      child: MaterialApp(
        
        initialRoute: 'splash',
        routes: {
          'home': (context) => const HomePage(),
          'splash': (context) => const SplashPage(),
          'login': (context) => const LoginPage(),
          'signup': (context) => const SignUpPage(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          iconTheme: IconThemeData(color: oranget1),
          scaffoldBackgroundColor: white,
        ),
      ),
    );
  }
}