import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:barber_flow/app.dart';
import 'package:barber_flow/core/di/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load envs
  await dotenv.load(fileName: ".env");

  // Dependency Injection
  configureDependencies();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Google Sign-In with Web Client ID
  await GoogleSignIn.instance.initialize(
    serverClientId:
        '675712429250-25i2j1ph0ignjvbuuutjf9u8tpdsrpa0.apps.googleusercontent.com',
  );

  runApp(const App());
}
