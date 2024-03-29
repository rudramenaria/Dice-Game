import 'dart:async';
import 'dart:developer';

import 'package:dice_game/UI/Dashboard/dashboard.screen.dart';
import 'package:dice_game/UI/Game/game.screen.dart';
import 'package:dice_game/UI/register%20and%20login/loginorsignup.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final FirebaseAuth auth = FirebaseAuth.instance;
User? user;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkLogin() async {
    user = auth.currentUser;
    if (user == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginOrSignUpScreen(),
          ),
        );
      });
    } else {
      log(user!.email.toString(), name: 'name');
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkLogin();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(height: 100, child: Image.asset("assets/dice.jpg")),
      ),
    );
  }
}
