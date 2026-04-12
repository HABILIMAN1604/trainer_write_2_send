import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart'; // Add this
import 'package:trainer_write_2_send/screen/sub_pages/sub_pages_layout.dart';

class BaseScannerPage extends StatefulWidget {
  final String title;
  final Function(String) onImageProcessed;

  const BaseScannerPage({
    super.key,
    required this.title,
    required this.onImageProcessed,
  });

  @override
  State<BaseScannerPage> createState() => _BaseScannerPageState();
}

class _BaseScannerPageState extends State<BaseScannerPage> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  final ImagePicker _picker = ImagePicker();
  
  // New state variable for the preview
  String? _imagePreviewPath;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(_cameras![0], ResolutionPreset.high);
      await _controller!.initialize();
      if (!mounted) return;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    try {
      final XFile image = await _controller!.takePicture();
      setState(() {
        _imagePreviewPath = image.path; // Show preview
      });
    } catch (e) {
      print("Capture Error: $e");
    }
  }

  Future<void> _pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100,);
    if (image != null) {
      setState(() {
        _imagePreviewPath = image.path; // Show preview
      });
    }
  }

  // --- OCR LOGIC TRIGGER ---
  Future<void> _confirmAndExtract() async {
    if (_imagePreviewPath == null) return;

    print("--- STARTING OCR ---");
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFilePath(_imagePreviewPath!);

    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      
      // Printing the raw output as you requested
      print("Extracted Text: ${recognizedText.text}");
      
      // Pass the path back to the parent for future API calls
      widget.onImageProcessed(recognizedText.text);
      
      textRecognizer.close();
    } catch (e) {
      print("OCR Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: widget.title,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 1. DYNAMIC PREVIEW AREA
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _imagePreviewPath == null 
                        ? (_controller != null && _controller!.value.isInitialized
                            ? CameraPreview(_controller!)
                            : const Center(child: CircularProgressIndicator()))
                        : Image.file(File(_imagePreviewPath!), fit: BoxFit.contain),
                    ),
                  ),
                  // Only show corners if we are in camera mode
                  if (_imagePreviewPath == null) ...[
                    _buildEdge(top: 0, left: 0, isTop: true, isLeft: true),
                    _buildEdge(top: 0, right: 0, isTop: true, isLeft: false),
                    _buildEdge(bottom: 0, left: 0, isTop: false, isLeft: true),
                    _buildEdge(bottom: 0, right: 0, isTop: false, isLeft: false),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 2. CONTEXTUAL BUTTONS
            _imagePreviewPath == null ? _buildScannerButtons() : _buildPreviewButtons(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Buttons for Camera Mode
  Widget _buildScannerButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton.icon(
            onPressed: _captureImage,
            icon: const Icon(Icons.camera),
            label: const Text("CAPTURE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF67A4FF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: _pickFromGallery,
          child: const Text(
            "or choose from gallery",
            style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  // Buttons for Preview Mode
  Widget _buildPreviewButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => setState(() => _imagePreviewPath = null),
            icon: const Icon(Icons.refresh),
            label: const Text("RETAKE"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _confirmAndExtract,
            icon: const Icon(Icons.check),
            label: const Text("CONFIRM"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEdge({double? top, double? bottom, double? left, double? right, required bool isTop, required bool isLeft}) {
    // ... (Your existing _buildEdge code remains the same)
    const double edgeSize = 30.0;
    const double thickness = 4.0;
    const Color edgeColor = Color(0xFF67A4FF);
    return Positioned(
      top: top, bottom: bottom, left: left, right: right,
      child: SizedBox(
        width: edgeSize, height: edgeSize,
        child: Stack(
          children: [
            Positioned(
              left: isLeft ? 0 : null, right: isLeft ? null : 0,
              top: 0, bottom: 0,
              child: Container(width: thickness, color: edgeColor),
            ),
            Positioned(
              top: isTop ? 0 : null, bottom: isTop ? null : 0,
              left: 0, right: 0,
              child: Container(height: thickness, color: edgeColor),
            ),
          ],
        ),
      ),
    );
  }
}