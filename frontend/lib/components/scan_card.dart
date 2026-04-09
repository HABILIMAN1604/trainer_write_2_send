import 'package:flutter/material.dart';

class ScanCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onScan;

  const ScanCard({
    super.key, 
    required this.title, 
    required this.subtitle,
    required this.onScan
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20), // Space between cards
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          //The Subtitle
          Text(
            subtitle, // Display the unique subtitle here
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          
          const SizedBox(height: 20),
          // Center the button
          Center(
            child: ElevatedButton(
              onPressed: onScan,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF67A4FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text("Click to Scan"),
            ),
          ),
        ],
      ),
    );
  }
}