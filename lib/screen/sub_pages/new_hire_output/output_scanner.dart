import 'package:flutter/material.dart';
import 'package:trainer_write_2_send/components/base_scanner_page.dart';

class OutputScanner extends StatelessWidget {
  const OutputScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScannerPage(
      title: "New Hire Output Scanner",
      onCapture: () => print("Logic for Google Form/Output"),
      onGalleryTap: () => print("Open Gallery for Output"),
    );
  }
}