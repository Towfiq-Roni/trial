// import 'package:edge_detection/edge_detection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:camera/camera.dart';
//
// Future<void> getImage() async{
//   String? imagePath;
//
//   try{
//     imagePath = await EdgeDetection.detectEdge;
//     print("$imagePath");
//
//   } on PlatformException catch(e){
//     imagePath = e.toString();
//   }
//   if(!mounted){
//     return;
//   }
//
//   setState(() {
//     _imagePath = imagePath;
//     _image = _imagePath == null ? null : File(_imagePath!);
//   });
//
// }
//
// class CaptureImage extends StatelessWidget {
//   const CaptureImage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
