import 'package:flutter/material.dart';
import 'package:trainer_write_2_send/screen/main_pages/home_page.dart';
import 'package:trainer_write_2_send/screen/main_pages/info_page.dart';
import 'package:trainer_write_2_send/screen/main_pages/settings_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    const InfoPage(),
    const HomePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFC7DDFF), Color(0xFF778599)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // --- PERSISTENT HEADER WITH BUBBLES ---
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
                      // Header Content
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Welcome Trainer",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.menu, color: Colors.white),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // --- DYNAMIC CONTENT ---
              Expanded(
                child: _pages[_selectedIndex],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}