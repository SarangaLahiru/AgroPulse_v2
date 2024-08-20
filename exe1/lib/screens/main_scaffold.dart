import 'package:flutter/material.dart';

import '../widget/custom_bottom_navigation_bar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final int selectedIndex;
  final Function(int) onTap;

  MainLayout({
    required this.child,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onTap: onTap,
      ),
    );
  }
}
