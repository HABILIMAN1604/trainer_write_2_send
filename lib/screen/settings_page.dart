import 'package:flutter/material.dart';
import 'package:trainer_write_2_send/components/setting_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                SettingTile(
                  icon: Icons.phone_android,
                  title: "WhatsApp Configuration",
                  subtitle: "Set default report number",
                  onTap: () {},
                ),
                const Divider(indent: 70, endIndent: 20),
                SettingTile(
                  icon: Icons.link,
                  title: "Google Form Link",
                  subtitle: "Update production form URL",
                  onTap: () {},
                ),
                const Divider(indent: 70, endIndent: 20),
                SettingTile(
                  icon: Icons.camera_alt_outlined,
                  title: "Scanner Settings",
                  subtitle: "Adjust OCR sensitivity",
                  onTap: () {},
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 25),
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SettingTile(
              icon: Icons.delete_forever_outlined,
              title: "Clear Cache",
              subtitle: "Reset app data",
              onTap: () {},
              iconColor: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}