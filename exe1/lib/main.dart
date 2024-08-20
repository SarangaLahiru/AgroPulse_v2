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
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) =>
            HomePage(user: ModalRoute.of(context)!.settings.arguments as User),
        '/profile': (context) => ProfilePage(
            user: ModalRoute.of(context)!.settings.arguments as User),
        '/settings': (context) => SettingsPage(),
        '/pest-detection': (context) => PestDetectionPage(),
      },
    );
  }
}
