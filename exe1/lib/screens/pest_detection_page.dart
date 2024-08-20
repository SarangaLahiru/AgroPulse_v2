import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../model/user.dart'; // Ensure you import your User model
import './main_scaffold.dart'; // Import the new layout

class PestDetectionPage extends StatefulWidget {
  final User user;

  PestDetectionPage({required this.user});

  @override
  _PestDetectionPageState createState() => _PestDetectionPageState();
}

class _PestDetectionPageState extends State<PestDetectionPage> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Send image to backend
      _sendImageToBackend(_image!);
    }
  }

  Future<void> _sendImageToBackend(File image) async {
    try {
      final uri = Uri.parse('https://your-backend-url.com/pest-detection');
      final request = http.MultipartRequest('POST', uri)
        // ..fields['userId'] = widget.user.id // Include user ID if needed
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          image.path,
          contentType:
              MediaType('image', 'jpeg'), // Adjust content type if necessary
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully.');
        // Handle success
      } else {
        print('Failed to upload image.');
        // Handle failure
      }
    } catch (e) {
      print('Error uploading image: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 3, // Set the index to highlight the Pest Detection tab
      onTap: (index) {
        // Handle navigation for other tabs
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
          default:
            Navigator.pushReplacementNamed(context, '/pest-detection',
                arguments: widget.user);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pest Detection',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700,
              ),
            ),
            SizedBox(height: 20),
            _image == null
                ? Center(child: Text('No image selected.'))
                : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Take a Photo'),
            ),
            SizedBox(height: 20),
            Text(
              'Here you can provide information and functionalities for pest detection.',
              style: TextStyle(fontSize: 18, color: Colors.brown.shade600),
            ),
            // Add more widgets related to pest detection
          ],
        ),
      ),
    );
  }
}
