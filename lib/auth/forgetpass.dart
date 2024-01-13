import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPass();
}

class _ForgetPass extends State<ForgetPass> {
  final _emailController= TextEditingController();

  void dispose(){
    _emailController.dispose();
    super.dispose();
  }
  Future passwordreset()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email:_emailController.text.trim());
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text('Password reset link is sent to your Email !'),
            );
          });
    } on FirebaseAuthException catch(e){
      print(e);
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
                content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text('Enter your Email to receive the password recovery link',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),

        SizedBox(height: 10),

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius:BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
                borderRadius:BorderRadius.circular(12),
              ),
              hintText: 'Email',
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
        ),
        SizedBox(height: 10),
        MaterialButton(
            onPressed:passwordreset,
          child: Text('Reset'),
          color: Colors.green[200],
        ),
      ],
      ),
    );
  }
}