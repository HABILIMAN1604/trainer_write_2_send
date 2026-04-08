import 'package:flutter/material.dart';
import 'package:trainer_write_2_send/components/scan_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // We only return the scrollable list of cards here
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ScanCard(
            title: "New Hire Passover",
            subtitle: "Scan ID to send details via WhatsApp",
            onScan: () => print("WhatsApp Logic"),
          ),
          ScanCard(
            title: "New Hire Output",
            subtitle: "Scan production data for Google Form",
            onScan: () => print("Google Form Logic"),
          ),
        ],
      ),
    );
  }
}