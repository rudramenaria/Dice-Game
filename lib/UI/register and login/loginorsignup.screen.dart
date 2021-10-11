import 'package:dice_game/UI/register%20and%20login/login.screen.dart';
import 'package:dice_game/UI/register%20and%20login/register.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginOrSignUpScreen extends StatefulWidget {
  const LoginOrSignUpScreen({Key? key}) : super(key: key);

  @override
  _LoginOrSignUpScreenState createState() => _LoginOrSignUpScreenState();
}

class _LoginOrSignUpScreenState extends State<LoginOrSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('login')),
          FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  ),
                );
              },
              child: Text('Register')),
        ],
      ),
    );
  }
}
