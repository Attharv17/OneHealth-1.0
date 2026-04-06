import 'package:flutter/material.dart';
import 'screens/navigation_menu.dart'; // Import the new navigation shell

void main() {
  runApp(const OneHealthApp());
}

class OneHealthApp extends StatelessWidget {
  const OneHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OneHealth AI',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6366F1), // Indigo theme to match UI
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const NavigationMenu(), // Pointing to the new multi-menu shell
    );
  }
}