import 'package:aurahome/utils/app_constants.dart';
import 'package:aurahome/widgets/settings_card.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppConstants.textColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: const [
            SettingsCard(
              title: 'General',
              icon: Icons.settings,
            ),
            SettingsCard(
              title: 'Devices',
              icon: Icons.devices,
            ),
            SettingsCard(
              title: 'Notifications',
              icon: Icons.notifications,
            ),
          ],
        ),
      ),
    );
  }
}