import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();

    Timer(Duration(seconds: 5), (){
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);

    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Stack(
        children: [
          Image.asset(
            'assets/splash.png',
            fit:BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

        ],
      ),
    );
  }
}