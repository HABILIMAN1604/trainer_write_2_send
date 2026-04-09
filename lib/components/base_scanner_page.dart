import 'package:flutter/material.dart';
import 'package:trainer_write_2_send/screen/sub_pages/sub_pages_layout.dart';

class BaseScannerPage extends StatelessWidget {
  final String title;
  final VoidCallback onCapture;
  final VoidCallback onGalleryTap;

  const BaseScannerPage({
    super.key,
    required this.title,
    required this.onCapture,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: title,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 1. CAMERA AREA WITH CORNERS
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, color: Colors.white24, size: 50),
                        SizedBox(height: 10),
                        Text("Camera Preview will be here",
                            style: TextStyle(color: Colors.white24)),
                      ],
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

            // 2. CAPTURE BUTTON
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: onCapture,
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

            // 3. INSTRUCTIONS CARD
            Container(
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
                              onTap: onGalleryTap,
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
            ),
            const SizedBox(height: 20),
          ],
        ),
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