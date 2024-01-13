import 'package:flutter/material.dart';
import 'package:medminder/auth/authListener.dart';
import 'package:medminder/pages/add_medicine/add_medicine.dart';
import 'widgets/navbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedMinder',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent.shade400,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent.shade400,
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthListener(),
        '/nav': (context) => const Navbar(''),
        '/add': (context) => const AddMedicine(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
