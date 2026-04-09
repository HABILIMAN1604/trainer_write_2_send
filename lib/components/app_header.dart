import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final bool showMenuButton;

  const CustomHeader({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.showMenuButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'shared_app_header',
        child: Material(
          type: MaterialType.transparency,
          child: ClipRRect(
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
                // Content
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 40, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (showBackButton)
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          const SizedBox(width: 5),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: showBackButton ? 18 : 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      if (showMenuButton)
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
      ),
    );
  }
}