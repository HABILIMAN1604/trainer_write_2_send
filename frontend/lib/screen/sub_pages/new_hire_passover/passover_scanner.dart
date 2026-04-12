import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for Clipboard
import 'package:trainer_write_2_send/components/base_scanner_page.dart';
import 'package:trainer_write_2_send/services/api_service.dart'; 
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
      final report = await _apiService.processOcrText(rawExtractedText);
      if (report != null) {
        _showResultsDialog(report);
      } else {
        _showError("Failed to parse data. Please check server connection.");
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // --- FORMATTING LOGIC FOR COPYING ---
  String _generateFormattedReport(TrainingReport report) {
    final shiftA = report.trainees.where((t) => t.shift == "A").toList();
    final shiftB = report.trainees.where((t) => t.shift == "B").toList();
    final shiftC = report.trainees.where((t) => t.shift == "C").toList();

    StringBuffer buffer = StringBuffer();
    buffer.writeln("PASS OVER OPERATOR TRAINING NEW HIRES\n");
    buffer.writeln("DATE JOIN : ${report.dateJoin}");
    buffer.writeln("TRAINING DAY ${report.trainingDay}");
    buffer.writeln("LOC : ${report.location}\n");

    if (shiftA.isNotEmpty) {
      buffer.writeln("SHIFT A (${shiftA.length} PAX)");
      for (var t in shiftA) { buffer.writeln("${t.employeeId} - ${t.name}"); }
      buffer.writeln(""); 
    }
    if (shiftB.isNotEmpty) {
      buffer.writeln("SHIFT B (${shiftB.length} PAX)");
      for (var t in shiftB) { buffer.writeln("${t.employeeId} - ${t.name}"); }
      buffer.writeln("");
    }
    if (shiftC.isNotEmpty) {
      buffer.writeln("SHIFT C (${shiftC.length} PAX)");
      for (var t in shiftC) { buffer.writeln("${t.employeeId} - ${t.name}"); }
    }

    return buffer.toString();
  }

  void _copyToClipboard(TrainingReport report) {
    final textToCopy = _generateFormattedReport(report);
    Clipboard.setData(ClipboardData(text: textToCopy)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Formatted report copied!")),
      );
    });
  }

  void _showResultsDialog(TrainingReport report) {
    final shiftA = report.trainees.where((t) => t.shift == "A").toList();
    final shiftB = report.trainees.where((t) => t.shift == "B").toList();
    final shiftC = report.trainees.where((t) => t.shift == "C").toList();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Extracted Data", style: TextStyle(fontSize: 18)),
            IconButton(
              icon: const Icon(Icons.copy, color: Color(0xFF67A4FF)),
              onPressed: () => _copyToClipboard(report),
              tooltip: "Copy Formatted",
            )
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("PASS OVER OPERATOR TRAINING NEW HIRES", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blueGrey)),
                const SizedBox(height: 12),
                Text("DATE JOIN : ${report.dateJoin}"),
                Text("TRAINING DAY ${report.trainingDay}: ${report.dateJoin}"),
                Text("LOC : ${report.location}"),
                const Divider(height: 30),
                
                if (shiftA.isNotEmpty) ...[
                  Text("SHIFT A (${shiftA.length} PAX)", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ...shiftA.map((t) => Text("${t.employeeId} - ${t.name}")),
                  const SizedBox(height: 15),
                ],
                
                if (shiftB.isNotEmpty) ...[
                  Text("SHIFT B (${shiftB.length} PAX)", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ...shiftB.map((t) => Text("${t.employeeId} - ${t.name}")),
                  const SizedBox(height: 15),
                ],

                if (shiftC.isNotEmpty) ...[
                  Text("SHIFT C (${shiftC.length} PAX)", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ...shiftC.map((t) => Text("${t.employeeId} - ${t.name}")),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("RETAKE PICTURE", style: TextStyle(color: Colors.redAccent)),
          ),
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
          onImageProcessed: (String rawText) => _handleOcrResults(rawText),
        ),
        if (_isLoading)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(color: Color(0xFF67A4FF)),
            ),
          ),
      ],
    );
  }
}