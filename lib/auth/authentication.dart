import 'package:flutter/material.dart';
import 'package:medminder/auth/signin.dart';
import 'package:medminder/auth/signup.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool showLoginPage = true;
  
  togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {

    // Send either in login page or in register page
    if (showLoginPage) {
      return Signin(togglePage: togglePage);
    } else {
      return Signup(togglePage: togglePage);
    }
  }
}