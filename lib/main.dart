import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:barber_flow/app.dart';
import 'package:barber_flow/core/di/injection_container.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load envs
  await dotenv.load(fileName: ".env");

  // Dependency Injection
  configureDependencies();

  // Initialize Firebase (descomentar após flutterfire configure)
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(const App());
}
