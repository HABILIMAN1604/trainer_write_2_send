import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trainer_write_2_send/screen/sub_pages/sub_pages_layout.dart';

class BaseScannerPage extends StatefulWidget {
  final String title;
  // We change these to accept the File/Path once captured
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

  // GALLERY LOGIC
  Future<void> _pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      widget.onImageProcessed(image.path);
    }
  }

  // CAMERA CAPTURE LOGIC
  Future<void> _captureImage() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    try {
      final XFile image = await _controller!.takePicture();
      widget.onImageProcessed(image.path);
    } catch (e) {
      print("Capture Error: $e");
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
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  // LIVE CAMERA PREVIEW
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: (_controller != null && _controller!.value.isInitialized)
                          ? CameraPreview(_controller!)
                          : const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  _buildEdge(top: 0, left: 0, isTop: true, isLeft: true),
                  _buildEdge(top: 0, right: 0, isTop: true, isLeft: false),
                  _buildEdge(bottom: 0, left: 0, isTop: false, isLeft: true),
                  _buildEdge(bottom: 0, right: 0, isTop: false, isLeft: false),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: _captureImage,
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text("CAPTURE & EXTRACT",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF67A4FF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildInstructions(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Color(0xFF67A4FF)),
          const SizedBox(width: 15),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
                children: [
                  const TextSpan(text: "Align the paper within the corners to scan, or "),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: _pickFromGallery,
                      child: const Text(
                        "choose a photo from your device",
                        style: TextStyle(
                          color: Color(0xFF67A4FF),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const TextSpan(text: " below."),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEdge({double? top, double? bottom, double? left, double? right, required bool isTop, required bool isLeft}) {
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