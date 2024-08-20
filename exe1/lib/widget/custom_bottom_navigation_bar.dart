import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor:
          Color.fromARGB(255, 8, 174, 16), // Creative background color
      selectedItemColor: Colors.white, // Color for selected item
      unselectedItemColor:
          Colors.white.withOpacity(0.7), // Color for unselected items
      elevation: 8, // Shadow elevation
      type: BottomNavigationBarType.fixed, // Fixed type for more items
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bug_report),
          label: 'Pest Detection',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onTap,
      showUnselectedLabels: true,
      selectedFontSize: 14, // Font size for selected label
      unselectedFontSize: 12, // Font size for unselected label
    );
  }
}
