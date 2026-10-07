import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  // Controller responsible for managing the camera.
  CameraController? cameraController;

  // Contains the photo after it has been captured.
  XFile? capturedPhoto;

  @override
  void initState() {
    super.initState();

    // Initialize the camera when ScanPage is created.
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      // Retrieve the cameras available on the device.
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        debugPrint('No cameras available');
        return;
      }

      // Select the first available camera.
      final backCamera = cameras.first;

      // Create the camera controller.
      cameraController = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      // Wait until the camera has finished initializing.
      await cameraController!.initialize();

      // The page might have been closed while initialization was running.
      if (!mounted) {
        return;
      }

      // Rebuild the page and display the camera preview.
      setState(() {});
    } catch (error) {
      debugPrint('Camera initialization error: $error');
    }
  }

  Future<void> capturePhoto() async {
    // Store the controller in a local variable.
    final controller = cameraController;

    // Stop if the controller is missing or the camera is not ready.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    try {
      // Take the photograph and receive the resulting XFile.
      final photo = await controller.takePicture();

      // The page might have been closed while taking the photo.
      if (!mounted) {
        return;
      }

      // Save the photo inside the State.
      setState(() {
        capturedPhoto = photo;
      });

      debugPrint('Photo saved at: ${photo.path}');
    } catch (error) {
      debugPrint('Camera capture error: $error');
    }
  }

  void retakePhoto() {
    // Remove the selected photo from the State.
    setState(() {
      capturedPhoto = null;
    });
  }

  Widget buildCameraPreview() {
    // Show a progress indicator while the camera is initializing.
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      children: [
        // Camera preview occupies the available screen.
        Positioned.fill(
          child: CameraPreview(cameraController!),
        ),

        // Capture button displayed over the camera preview.
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
    );
  }

  Widget buildPhotoPreview() {
    return Column(
      children: [
        // Display the photograph using its local path.
        Expanded(
          child: Image.file(
            File(capturedPhoto!.path),
            fit: BoxFit.contain,
          ),
        ),

        // Return to the live camera preview.
        ElevatedButton(
          onPressed: retakePhoto,
          child: const Text('Retake'),
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  @override
  void dispose() {
    // Release the native camera resources when leaving the page.
    cameraController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Card'),
      ),

      // Show the camera when there is no photo.
      // Show the captured image when a photo exists.
      body: capturedPhoto == null ? buildCameraPreview() : buildPhotoPreview(),
    );
  }
}
