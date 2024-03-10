import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/FaceAuth/Login.dart';
import 'package:portfolio/portfolio.dart';
import 'package:velocity_x/velocity_x.dart';
Future<void> main() async {
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBU9vBDBADK63PW_2WDORP2YT23FbetVuI",
      projectId: "portfolio-5e1b6",
      storageBucket: "portfolio-5e1b6.appspot.com",
      messagingSenderId: "711500496347",
      appId: "1:711500496347:web:1236ab27283e854744fbfe",
    ));
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: Vx.purple800,
          primaryColor: Vx.purple900,
          useMaterial3: true,
          fontFamily: "custom"),
      home: FutureBuilder(
        future: _auth.authStateChanges().first,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return loading screen while checking authentication state
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              // User is logged in, navigate to Home Screen
              return const Portfolio();
            } else {
              // User is not logged in, navigate to Login Screen
              return FaceAuthenticationPage();
            }
          }
        },
      ),
    );
  }
}
