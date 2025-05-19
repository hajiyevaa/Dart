import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Explorer App',
      theme: ThemeData(
        // Suggestion: Aligning with the green/grey gradients used in AppBar for consistency
        primarySwatch: Colors.green, // This color will influence various default widgets
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        // Define default text styles for your app (optional but good practice)
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white), // Example for large titles
          titleMedium: TextStyle(color: Colors.black), // Used in BookCard grid title
          bodyLarge: TextStyle(color: Colors.black87), // Used in BookCard tagline
          bodyMedium: TextStyle(color: Colors.black87),
        ),
        // Define default AppBar theme
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white, // Default text color for app bar titles
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white), // Default icon color for app bar icons
        ),
      ),
      home: const HomePage(), // Your application starts with HomePage
      debugShowCheckedModeBanner: false, // Removes the "DEBUG" banner in debug mode
    );
  }
}