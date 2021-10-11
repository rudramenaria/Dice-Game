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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RawMaterialButton(
                constraints: const BoxConstraints(minHeight: 50, minWidth: 200),
                fillColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                )),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: RawMaterialButton(
                constraints: const BoxConstraints(minHeight: 50, minWidth: 200),
                fillColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
