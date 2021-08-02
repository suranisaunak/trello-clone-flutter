import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trelloapp/src/constants/firebase_constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double iconSize = 0.0;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        iconSize = 0.2;
      });
    });
    if (auth.currentUser == null) {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/loginscreen');
      });
    } else {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/homescreen');
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          width: height * iconSize,
          height: height * iconSize,
          child: ClipOval(
            child: Image.asset(
              "assets/images/splash.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
