import 'package:flutter/material.dart';

import '../model/user.dart';
import './main_scaffold.dart'; // Import the new layout

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 1, // Set the index to highlight the Profile tab
      onTap: (index) {
        // Handle navigation for other tabs
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home', arguments: user);
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/settings',
                arguments: user);
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/pest-detection',
                arguments: user);
            break;
          default:
            Navigator.pushReplacementNamed(context, '/profile',
                arguments: user);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 4,
              color: Colors.blueGrey.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile Information',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade800,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.person,
                            color: Colors.blueGrey.shade600, size: 40),
                        SizedBox(width: 16),
                        Text(
                          user.name,
                          style: TextStyle(
                              fontSize: 20, color: Colors.blueGrey.shade900),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.email,
                            color: Colors.blueGrey.shade600, size: 40),
                        SizedBox(width: 16),
                        Text(
                          user.email,
                          style: TextStyle(
                              fontSize: 18, color: Colors.blueGrey.shade700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Add additional profile-related widgets here if needed
          ],
        ),
      ),
    );
  }
}
