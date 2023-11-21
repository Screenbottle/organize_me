import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  late CameraController _controller;

  Future initCamera(CameraDescription cameraDescription) async {
    // create a CameraController
    _controller = CameraController(cameraDescription, ResolutionPreset.high);
    // Next, initialize the controller. This returns a Future.
    try {
      await _controller.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  Future takePicture() async {
  if (!_controller.value.isInitialized) {return null;}
  if (_controller.value.isTakingPicture) {return null;}
  try {
    await _controller.setFlashMode(FlashMode.off);
    XFile picture = await _controller.takePicture();
    // this should be replaced with navigation that does not rely on context
    await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: picture.path,
                ),
              ),
            );
  } on CameraException catch (e) {
    debugPrint('Error occured while taking picture: $e');
    return null;
  }
}

  @override
  void initState() {
    super.initState();
    // initialize the rear camera
    initCamera(widget.cameras[0]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Take a picture')),
        // You must wait until the controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner until the
        // controller has finished initializing.
        body: SafeArea(
            child: _controller.value.isInitialized
                ? CameraPreview(_controller)
                : const Center(child: CircularProgressIndicator())),);
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
