import 'package:flutter/material.dart';
import 'package:trainer_write_2_send/components/app_header.dart';
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
      //Gradient bg
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
              // --- REUSABLE HEADER ---
              const CustomHeader(
                title: "Welcome Trainer",
                showMenuButton: true,
                showBackButton: false,
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