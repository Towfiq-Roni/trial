import 'dart:async';
import 'dart:io';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: squareCapture(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

class squareCapture extends StatefulWidget {
  squareCapture({
    Key? key,
    required this.camera,})
      : super(key: key);
  final CameraDescription camera;

  @override
  squareCaptureState createState() => squareCaptureState();
}

class squareCaptureState extends State<squareCapture> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.max,
    );
    _initializeControllerFuture = _controller.initialize(
        // onPressed: () async {
        //   try {
        //     await _initializeControllerFuture;
        //     final image = (await EdgeDetection.detectEdge);
        //   }
        // }
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take Picture'),),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          }
          else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // await _initializeControllerFuture;
            // final image = await _controller.takePicture();
            final imagePath = (await EdgeDetection.detectEdge);
            if (!mounted) {
              return;
            }
            // if (mounted) {
            //   final image = EdgeDetection.detectEdge;
            //   return;
            // }
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) =>
                  DisplayPicture(
                      imagePath: imagePath!)),
            );
          }
          catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPicture extends StatelessWidget {
  final String imagePath;

  DisplayPicture({Key? key, required this.imagePath,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('The Picture Taken'),),
      body: Image.file(File(imagePath)),
    );
  }
}