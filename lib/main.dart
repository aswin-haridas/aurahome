import 'package:aurahome/screens/home_page.dart';
import 'package:aurahome/utils/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuraHome',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.primaries[AppConstants.primaryColor.value],
        scaffoldBackgroundColor: AppConstants.backgroundLightColor,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: AppConstants.textColor,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: AppConstants.textColor,
            fontSize: 14,
          ),
          displayLarge: TextStyle(
            color: AppConstants.textColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: AppConstants.textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}