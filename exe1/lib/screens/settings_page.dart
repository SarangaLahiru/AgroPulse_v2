import 'package:flutter/material.dart';

import '../model/user.dart'; // Ensure you import your User model
import './main_scaffold.dart'; // Import the new layout

class SettingsPage extends StatelessWidget {
  final User user;

  SettingsPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 2, // Set the index to highlight the Settings tab
      onTap: (index) {
        // Handle navigation for other tabs
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home', arguments: user);
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/profile',
                arguments: user);
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/pest-detection',
                arguments: user);
            break;
          default:
            Navigator.pushReplacementNamed(context, '/settings',
                arguments: user);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
            SizedBox(height: 20),
            // Add your settings options here
            Text(
              'Here you can add various settings options or configurations.',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey.shade700),
            ),
            // Add more widgets to handle different settings
          ],
        ),
      ),
    );
  }
}
