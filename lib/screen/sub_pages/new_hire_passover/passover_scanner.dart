import 'package:flutter/material.dart';
import 'package:trainer_write_2_send/components/base_scanner_page.dart'; // Import your reusable layout

class PassoverScanner extends StatelessWidget {
  const PassoverScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScannerPage(
      title: "New Hire Passover Scanner",
      onImageProcessed: (String path) {
              print("Captured image at: $path");
      },
    );
  }
}