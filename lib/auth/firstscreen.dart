import 'package:flutter/material.dart';
import 'package:medminder/auth/authentication.dart';
import 'package:medminder/auth/signin.dart';
import 'package:medminder/auth/signup.dart';
import 'package:medminder/widgets/custom.dart';

import '../widgets/button.dart';

class Firstscreen extends StatelessWidget {
  const Firstscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Custom(
      child: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0,
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: 'Welcome to\n',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 39.0,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'PlaypenSans')),
                        TextSpan(
                            text: '\nMedMinder',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 65,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Ephesis'
                                // height: 0,
                                ))
                      ],
                    ),
                  ),
                ),
              )),
          const Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                    child: Button(
                      buttonText: 'Sign in',
                      onTap: Signin(togglePage: null),
                      color: Colors.yellow,
                      textColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Button(
                      buttonText: 'Sign up',
                      onTap: Signup(togglePage: null),
                      color: Colors.blue,
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
