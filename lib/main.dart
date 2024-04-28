import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
//import 'package:flutter_app/login.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the background color using scaffoldBackgroundColor
        scaffoldBackgroundColor: Color(0xFF0A101F),
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
