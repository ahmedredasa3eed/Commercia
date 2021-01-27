
import 'package:commercia/auth/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {

  static const route = 'splash-screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if(FirebaseAuth.instance.currentUser != null){
        Navigator.pushReplacementNamed(context, HomeScreen.route);
      }else{
        Navigator.pushReplacementNamed(context, AuthScreen.route);
      }
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
