import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // Here you directly define your theme settings
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 239, 206, 56)),
        useMaterial3: true,
      ),
      home: Login(),
    );
  }
}

