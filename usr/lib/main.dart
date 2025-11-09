import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/poet_dashboard_screen.dart';
import 'screens/diwan_details_screen.dart';
import 'screens/poem_viewer_screen.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(const PoetryPlatformApp());
}

class PoetryPlatformApp extends StatelessWidget {
  const PoetryPlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'منصة الشعر والشعراء',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Arial',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.brown),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.brown),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.brown,
          elevation: 2,
          centerTitle: true,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/poet-dashboard': (context) => const PoetDashboardScreen(),
        '/diwan-details': (context) => const DiwanDetailsScreen(),
        '/poem-viewer': (context) => const PoemViewerScreen(),
        '/search': (context) => const SearchScreen(),
      },
    );
  }
}