import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

//stafull widget for the camera
//
class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  //this interrogate if the camera exist or not
  CameraController? cameraController;
  Future<void> capturePhoto() async {
    final controller = cameraController;

    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    try {
      final photo = await controller.takePicture();

      debugPrint('Photo saved at: ${photo.path}');
    } catch (error) {
      debugPrint('Camera error: $error');
    }
  }

  //initialize the camera
  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  // here is set a function set the camera in await or async
  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      debugPrint('No cameras available');
      return;
    }
    final backCamera = cameras.first;

    cameraController = CameraController(
      backCamera,
      ResolutionPreset.high,
    );

    await cameraController!.initialize();
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  //this state dispose away the cameera aftger using it
  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Card"),
      ),
      body: cameraController == null || !cameraController!.value.isInitialized
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(cameraController!),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 24,
                  child: Center(
                    child: FloatingActionButton(
                      onPressed: capturePhoto,
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
