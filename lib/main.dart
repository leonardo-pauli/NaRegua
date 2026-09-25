import 'package:flutter/foundation.dart' show kIsWeb;
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
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Failed to load .env file: $e");
  }

  // Dependency Injection
  configureDependencies();

  // Initialize Firebase
  if (Firebase.apps.isEmpty) {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else {
      await Firebase.initializeApp();
    }
  }

  // Initialize Google Sign-In with Web Client ID
  try {
    await GoogleSignIn.instance.initialize(
      serverClientId: '675712429250-25i2j1ph0ignjvbuuutjf9u8tpdsrpa0.apps.googleusercontent.com',
    );
  } catch (e) {
    debugPrint("Failed to initialize GoogleSignIn: $e");
  }

  runApp(const App());
}
