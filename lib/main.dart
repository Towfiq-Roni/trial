import 'dart:async';
import 'dart:io';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_camera_overlay/model.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';

// import 'package:flutter_camera_overlay/flutter_camera_overlay.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   final cameras = await availableCameras();
//   final firstCamera = cameras.first;
//   runApp(
//     MaterialApp(
//       theme: ThemeData.dark(),
//       home: squareCapture(
//         // Pass the appropriate camera to the TakePictureScreen widget.
//         camera: firstCamera,
//       ),
//     ),
//   );
// }
//
// class squareCapture extends StatefulWidget {
//   squareCapture({
//     Key? key,
//     required this.camera,})
//       : super(key: key);
//   final CameraDescription camera;
//
//   @override
//   squareCaptureState createState() => squareCaptureState();
// }
//
// class squareCaptureState extends State<squareCapture> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.max,
//     );
//     _initializeControllerFuture = _controller.initialize(
//         // onPressed: () async {
//         //   try {
//         //     await _initializeControllerFuture;
//         //     final image = (await EdgeDetection.detectEdge);
//         //   }
//         // }
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Take Picture'),),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_controller);
//           }
//           else {
//             return const Center(child: CircularProgressIndicator(),);
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           try {
//             // await _initializeControllerFuture;
//             // final image = await _controller.takePicture();
//             final imagePath = (await EdgeDetection.detectEdge);
//             if (!mounted) {
//               return;
//             }
//             // if (mounted) {
//             //   final image = EdgeDetection.detectEdge;
//             //   return;
//             // }
//             await Navigator.of(context).push(
//               MaterialPageRoute(builder: (context) =>
//                   DisplayPicture(
//                       imagePath: imagePath!)),
//             );
//           }
//           catch (e) {
//             print(e);
//           }
//         },
//         child: const Icon(Icons.camera_alt),
//       ),
//     );
//   }
// }
//
// class DisplayPicture extends StatelessWidget {
//   final String imagePath;
//
//   DisplayPicture({Key? key, required this.imagePath,})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('The Picture Taken'),),
//       body: Image.file(File(imagePath)),
//     );
//   }
// }



void main() {
  runApp(const CaptureEdge());
}

class CaptureEdge extends StatefulWidget {
  const CaptureEdge({Key? key}) : super(key: key);

  @override
  _CaptureEdgeState createState() => _CaptureEdgeState();
}

class _CaptureEdgeState extends State<CaptureEdge> {
  String? _imagePath;

  detectObject() async {
    _imagePath = await EdgeDetection.detectEdge;
    setState(() {
        // return detectObjectF();
    });
    return detectObjectF();
  }

  detectObjectF() async{
    if(detectObject()==EdgeDetection.detectEdge){
      Timer(const Duration(milliseconds: 100), () {
        //after 0.1 seconds detection this will be called,
        //once this is called take picture
        return ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Edge"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: detectObject,
                  child: const Text('Scan Object'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Cropped image path:',
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                child: Text(
                  _imagePath ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Visibility(
                  visible: _imagePath != null,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.file(
                      File(_imagePath ?? ''),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

