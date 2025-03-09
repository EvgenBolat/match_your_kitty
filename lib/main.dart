import 'package:flutter/material.dart';
import 'package:match_your_kitty/src/screens/cat_details_screen.dart';
import 'package:match_your_kitty/src/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match Your Kitty',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF4E1C1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD2B48C),
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        CatDetailPage.routeName: (context) => const CatDetailPage(),
      },
    );
  }
}
