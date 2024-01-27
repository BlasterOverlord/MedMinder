import 'package:flutter/material.dart';
import 'package:medminder/auth/authListener.dart';
import 'package:medminder/pages/add_medicine/add_medicine.dart';
import 'package:medminder/pages/splash_screen.dart';
import 'package:medminder/service/notificationService.dart';
import 'widgets/navbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.requestNotificationPermission();
  await NotificationService().init();
  tz.initializeTimeZones();
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
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/': (context) => const AuthListener(),
        '/nav': (context) => const Navbar(''),
        '/add': (context) => const AddMedicine(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
