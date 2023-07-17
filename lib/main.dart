import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inter_iit/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var newUser;
  Future<Widget> decideScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var onboarded = prefs.get('is_onboarded');
    if (onboarded == true) {
      return HomeScreen(pageIndex: 0,);
    }
    return OnboardingScreen();
  }

  @override
  void initState() {
    // TODO: implement initState
    decideScreen().then((route) {
      Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => route)),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: const Text(
        'Recalling...',
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
      seconds: 5,
      // gradientBackground: const LinearGradient(
      //   colors: [Colors.purple, Colors.blueAccent],
      //   begin: Alignment.bottomLeft,
      //   end: Alignment.topRight,
      //   stops: [0.4, 0.7],
      //   tileMode: TileMode.repeated,
      // ),
      image: Image.asset(
        'assets/loader.gif',
      ),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      onClick: () => print("Click Detected"),
      // loaderColor: Colors.white,
      useLoader: false,
    );
  }
}
