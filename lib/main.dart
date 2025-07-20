import 'package:aurahomev1/screens/home_page.dart';
import 'package:aurahomev1/utils/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        primarySwatch: MaterialColor(
          AppConstants.primaryColor.value,
          const <int, Color>{
            50: Color(0xFFEBE8E1), // 10%
            100: Color(0xFFD6D2B8), // 20%
            200: Color(0xFFB2A86F), // 30%
            300: Color(0xFF8E7D26), // 40%
            400: Color(0xFF7A6B1E), // 50%
            500: AppConstants.primaryColor, // 60%
            600: Color(0xFF4D3B12), // 70%
            700: Color(0xFF3B2D0E), // 80%
            800: Color(0xFF2A1F0B), // 90%
            900: Color(0xFF1A1007), // 100%
          },
        ),
        scaffoldBackgroundColor: AppConstants.backgroundLightColor,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppConstants.textColor, fontSize: 16),
          bodyMedium: TextStyle(color: AppConstants.textColor, fontSize: 14),
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
