import 'dart:convert';
import 'dart:developer' as d;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_game/main.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool loading = true;
  int totalScore = 0;
  int _diceValue = 1;
  int numberOfChances = 0;
  int totalChances = 10;
  int remainingChances = 10;
  Map? data;

  CollectionReference _leaderboard =
      FirebaseFirestore.instance.collection('leaderboard');

  setPreference() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString(
      'data',
      jsonEncode(
        {
          "completed": remainingChances == 0 ? true : false,
          "remainingChances": remainingChances,
          "totalScore": totalScore
        },
      ),
    );
  }

  getPreference() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    data = jsonDecode(s.getString('data') ?? '{}');
    d.log(data.toString());
    setState(() {
      remainingChances = data!['remainingChances'] ?? 10;
      totalScore = data!['totalScore'] ?? 0;
      loading = false;
    });
  }

  rollDice() async {
    d.log(remainingChances.toString());
    if (remainingChances == 1) {
      setState(() {
        _diceValue = Random().nextInt(6) + 1;
        totalScore += _diceValue;
        remainingChances--;
      });
      setPreference();
      await _leaderboard
          .add({"name": user!.email ?? "Name", "points": totalScore});
      d.log('done');
    } else {
      setPreference();
      setState(() {
        _diceValue = Random().nextInt(6) + 1;
        totalScore += _diceValue;
        numberOfChances++;
        remainingChances--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPreference();
  }

  @override
  Widget build(BuildContext context) {
    return (data!.isNotEmpty && data!['completed'] == true)
        ? Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: const Center(
              child: Text(
                "You can only play this Game once.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: LoadingOverlay(
              isLoading: loading,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset('assets/dice.jpg'),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 150,
                          width: 150,
                          child: Text(
                            _diceValue.toString(),
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Total Chance Remaining " + remainingChances.toString(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Your Total Score " + totalScore.toString(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  remainingChances == 0
                      ? const Text(
                          "Your Game is Completed.\nThank you for playing",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
            floatingActionButton: remainingChances == 0
                ? SizedBox.shrink()
                : FloatingActionButton.extended(
                    onPressed: rollDice,
                    label: const Text('Click Here to Roll'),
                  ),
          );
  }
}
