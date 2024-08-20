import 'package:flutter/material.dart';

class PestDetectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pest Detection'),
      ),
      body: Center(
        child: Text(
          'Pest Detection Content Here',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
