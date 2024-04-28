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
    _controller = CameraController(
      CameraDescription(
        sensorOrientation: 1,
        name: '0',
        lensDirection: CameraLensDirection.back
      ), 
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

// User Interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture, 
        builder: ((context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.circle_outlined,
          color: Colors.grey,
        ),
        onPressed: () async {
          try {
            final image = await _controller.takePicture();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PreviewScreen(imagePath: image.path),
                ));
          } catch (e) {}
        }, 
      ),
    );
  }
}

//Preview Screen
class PreviewScreen extends StatelessWidget {
  final String imagePath;

  const PreviewScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
      ),
      body: Center(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}