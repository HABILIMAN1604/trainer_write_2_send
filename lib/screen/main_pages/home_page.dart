import 'package:flutter/material.dart';
import 'package:trainer_write_2_send/components/scan_card.dart';
import 'package:trainer_write_2_send/screen/sub_pages/new_hire_passover/passover_scanner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ScanCard(
            title: "New Hire Passover",
            subtitle: "Scan ID to send details via WhatsApp",
            onScan: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PassoverScanner(),
                ),
              );
            },
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