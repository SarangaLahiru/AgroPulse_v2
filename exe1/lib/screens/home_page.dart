import 'package:flutter/material.dart';

import '../model/user.dart';
import './main_scaffold.dart'; // Import the new layout

class HomePage extends StatefulWidget {
  final User user;

  HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to different pages based on the selected index
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home',
            arguments: widget.user);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/profile',
            arguments: widget.user);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/settings',
            arguments: widget.user);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/pest-detection',
            arguments: widget.user);
        break;
      default:
        Navigator.pushReplacementNamed(context, '/home',
            arguments: widget.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: _selectedIndex,
      onTap: _onItemTapped,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 4,
                color: Colors.lightGreen.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${widget.user.name}!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade900,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            widget.user.email,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'What would you like to do today?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: <Widget>[
                    _buildGridCard(
                      icon: Icons.home,
                      label: 'Home',
                      onTap: () => _onItemTapped(0),
                    ),
                    _buildGridCard(
                      icon: Icons.person,
                      label: 'Profile',
                      onTap: () => _onItemTapped(1),
                    ),
                    _buildGridCard(
                      icon: Icons.settings,
                      label: 'Settings',
                      onTap: () => _onItemTapped(2),
                    ),
                    _buildGridCard(
                      icon: Icons.bug_report,
                      label: 'Pest Detection',
                      onTap: () => _onItemTapped(3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridCard({
    required IconData icon,
    required String label,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.green.shade900),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
