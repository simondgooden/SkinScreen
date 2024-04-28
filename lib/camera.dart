import 'dart:io';
import 'package:flutter_app/home.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    _controller = CameraController(CameraDescription(sensorOrientation: 1,
      name: '0',
      lensDirection: CameraLensDirection.back), resolutionPreset)
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

// User Interface
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

//Preview Screen

class PreviewScreen extends StatelessWidget {
  final String imagePath;

  const PreviewScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
