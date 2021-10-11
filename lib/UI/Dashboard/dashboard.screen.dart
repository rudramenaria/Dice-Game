import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice_game/UI/Game/game.screen.dart';
import 'package:dice_game/UI/register%20and%20login/loginorsignup.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class DashboardScreen extends StatefulWidget {
  final User? userData;
  const DashboardScreen({Key? key, this.userData}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // CollectionReference _leaderboard =
  Query _leaderboard = FirebaseFirestore.instance
      .collection('leaderboard')
      .orderBy("points", descending: true);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Leader Board'),
          leading: const SizedBox.shrink(),
          actions: [
            SizedBox(
              child: IconButton(
                icon: const Icon(Icons.power_settings_new_sharp),
                onPressed: () async {
                  SharedPreferences s = await SharedPreferences.getInstance();
                  s.setString('data', jsonEncode({}));
                  await auth.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginOrSignUpScreen(),
                    ),
                    ModalRoute.withName("/"),
                  );
                },
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GameScreen(),
              ),
            );
          },
          label: const Text('Play Now'),
          icon: const Icon(Icons.gamepad),
        ),
        body: StreamBuilder(
          stream: _leaderboard.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['name']),
                      subtitle: Text(documentSnapshot['points'].toString()),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
