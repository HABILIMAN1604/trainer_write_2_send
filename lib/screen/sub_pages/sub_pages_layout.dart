import 'package:flutter/material.dart';

class SubPageLayout extends StatelessWidget {
  final String title;
  final Widget child;

  const SubPageLayout({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // --- CONSISTENT HEADER WITH BUBBLES ---
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  color: const Color(0xFF67A4FF),
                  child: Stack(
                    children: [
                      // Bubble 1
                      Positioned(
                        top: -30,
                        left: -20,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF074094).withOpacity(0.4),
                          ),
                        ),
                      ),
                      // Bubble 2 
                      Positioned(
                        top: 10,
                        left: 40,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF3E6299).withOpacity(0.3),
                          ),
                        ),
                      ),
                      // Header Content with Back Button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 40, 20, 20),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // --- THE PAGE CONTENT ---
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}