import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MovieLibraryApp());
}

class MovieLibraryApp extends StatelessWidget {
  const MovieLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Library',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}