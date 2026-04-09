import 'package:flutter/material.dart';
import 'package:trainer_write_2_send/screen/sub_pages/sub_pages_layout.dart'; // Import your reusable layout

class PassoverScanner extends StatefulWidget {
  const PassoverScanner({super.key});

  @override
  State<PassoverScanner> createState() => _PassoverScannerState();
}

class _PassoverScannerState extends State<PassoverScanner> {
  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: "New Hire Passover",
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            
            // 1. CAMERA VIEW PLACEHOLDER
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.white54, size: 50),
                    SizedBox(height: 10),
                    Text(
                      "Camera Preview will be here",
                      style: TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),



            // 2. CAPTURE BUTTON
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement Camera Capture & ML Kit OCR
                  print("Capture Triggered");
                },
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text(
                  "CAPTURE & EXTRACT",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF67A4FF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
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
                        style: const TextStyle(fontSize: 11, color: Colors.black87, height: 1.4),
                        children: [
                          const TextSpan(
                            text: "Align the paper within the corners to scan, or ",
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: GestureDetector(
                              onTap: () {
                                // Dummy gallery trigger
                                print("Gallery opened");
                              },
                              child: const Text(
                                "choose a photo from your device",
                                style: TextStyle(
                                  color: Color(0xFF67A4FF),
                                  fontSize: 11,
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
}