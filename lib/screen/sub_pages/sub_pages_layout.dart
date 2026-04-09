import 'package:flutter/material.dart';
import 'package:trainer_write_2_send/components/app_header.dart';

class SubPageLayout extends StatelessWidget {
  final String title;
  final Widget child;

  const SubPageLayout({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(title: title, showBackButton: true),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}