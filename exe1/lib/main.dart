import 'package:flutter/material.dart';

import 'model/user.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/pest_detection_page.dart';
import 'screens/profile_page.dart';
import 'screens/register_page.dart';
import 'screens/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth',
      theme: ThemeData(
        primarySwatch: Colors.green, // Primary color theme for your app
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          // Background color for BottomNavigationBar
          selectedItemColor: Colors.white,
          unselectedItemColor:
              const Color.fromARGB(255, 223, 223, 223).withOpacity(0.6),
          elevation: 5,
        ),
        // Define other theme properties as needed
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) =>
            HomePage(user: ModalRoute.of(context)!.settings.arguments as User),
        '/profile': (context) => ProfilePage(
            user: ModalRoute.of(context)!.settings.arguments as User),
        '/settings': (context) => SettingsPage(
            user: ModalRoute.of(context)!.settings.arguments as User),
        '/pest-detection': (context) => PestDetectionPage(
            user: ModalRoute.of(context)!.settings.arguments as User),
      },
    );
  }
}
