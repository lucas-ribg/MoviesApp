import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/screens/home_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie APP',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity, 
        colorScheme: 
          ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.black),
      ),
      home: const Home(),
    );
  }
}
