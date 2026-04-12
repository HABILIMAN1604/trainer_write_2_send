import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/training_report.dart';

class ApiService {
  // Update this to 10.0.2.2 for emulator or your PC IP for real device
  static const String baseUrl = "http://172.20.10.8:5258/api/trainer";

  Future<TrainingReport?> processOcrText(String rawText) async {
    try {
      final url = Uri.parse('$baseUrl/process');
      
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"rawText": rawText}),
      );

      if (response.statusCode == 200) {
        // Decode the JSON into our TrainingReport object
        final Map<String, dynamic> data = jsonDecode(response.body);
        return TrainingReport.fromJson(data);
      } else {
        print("Backend Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Connection Failed: $e");
      return null;
    }
  }
}