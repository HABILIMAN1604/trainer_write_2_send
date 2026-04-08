import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30.0), // Padding around the card
      child: Column(
        children: [
          // This creates the white, rounded card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              color: Colors.white, // Pure white for consistency
              borderRadius: BorderRadius.circular(30), // Matches your home cards
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05), // A very soft shadow
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Top Icon (now blue to match the theme on white)
                const Icon(Icons.qr_code_scanner_rounded, size: 70, color: Color(0xFF67A4FF)),
                const SizedBox(height: 15),
                
                // App Title
                const Text(
                  "TrainerWrite2Send",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87, // Dark text on white background
                  ),
                ),
                
                // Version
                const Text(
                  "Version 1.0.0",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                
                const Divider(height: 40, color: Colors.black12),
                
                // --- ABOUT SECTION ---
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "About this App",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Built to help production trainers bridge the gap between manual and digital reporting. "
                  "Instead of typing trainee data manually, this app converts physical inputs into digital "
                  "report formats for WhatsApp and Google Forms.",
                  style: TextStyle(
                    color: Colors.black54, // Soft black for reading
                    height: 1.6, // Better line spacing
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Developer Credit (kept subtle on the gradient background)
          const Text(
            "Developed by Habil Iman",
            style: TextStyle(color: Colors.white60, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}