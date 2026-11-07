import 'package:flutter/material.dart';
import 'screens/main_shell.dart';

class MoodBloomApp extends StatelessWidget {
  const MoodBloomApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF658B72);
    return MaterialApp(
      title: 'MoodBloom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
          surface: const Color(0xFFF8F7F1),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F7F1),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F7F1),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const MainShell(),
    );
  }
}
