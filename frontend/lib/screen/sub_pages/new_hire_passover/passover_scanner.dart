import 'package:flutter/material.dart';
import 'package:trainer_write_2_send/components/base_scanner_page.dart';
import 'package:trainer_write_2_send/services/api_service.dart'; // Your C# service
import 'package:trainer_write_2_send/models/training_report.dart';

class PassoverScanner extends StatefulWidget {
  const PassoverScanner({super.key});

  @override
  State<PassoverScanner> createState() => _PassoverScannerState();
}

class _PassoverScannerState extends State<PassoverScanner> {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  Future<void> _handleOcrResults(String rawExtractedText) async {
    setState(() => _isLoading = true);

    try {
      // 1. Send the raw text from ML Kit to your C# Backend
      final report = await _apiService.processOcrText(rawExtractedText);

      if (report != null) {
        // 2. Success! You now have your clean date, location, and trainees
        _showResultsDialog(report);
      } else {
        _showError("Failed to parse data. Please check server connection.");
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showResultsDialog(TrainingReport report) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Passover Data Extracted"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Date: ${report.dateJoin}"),
              Text("Location: ${report.location}"),
              const Divider(),
              ...report.trainees.map((t) => Text("${t.employeeId} - ${t.name} (${t.shift})")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BaseScannerPage(
          title: "New Hire Passover Scanner",
          // We pass the extracted text directly to our handler
          onImageProcessed: (String rawText) => _handleOcrResults(rawText),
        ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(color: Color(0xFF67A4FF)),
          ),
      ],
    );
  }
}