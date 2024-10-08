import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Create an Account'),
        backgroundColor: Color.fromARGB(255, 20, 171, 3),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Image.asset(
              'assets/images/logo.jpeg',
              height: 150,
            ),
            Text(
              'Register',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 73, 183, 58),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _buildTextField(
              controller: _nameController,
              labelText: 'Full Name',
              icon: Icons.person,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _emailController,
              labelText: 'Email Address',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _passwordController,
              labelText: 'Password',
              icon: Icons.lock,
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                // Show loading indicator
                _showLoadingIndicator(context);

                // Handle registration logic
                final response = await _registerUser(
                  _emailController.text,
                  _passwordController.text,
                  _nameController.text,
                );

                // Hide loading indicator
                Navigator.pop(context);

                if (response.statusCode == 201) {
                  // Registration successful
                  await _showAlert(
                      context, 'Success', 'Registration successful! Welcome.');
                  Navigator.pushNamed(context, '/home');
                } else if (response.statusCode == 422) {
                  // Show validation errors
                  final Map<String, dynamic> responseData =
                      json.decode(response.body);
                  final String errors = _parseValidationErrors(responseData);
                  await _showAlertErr(context, 'Validation Error', errors);
                } else {
                  // Show general error message
                  final String errorMessage = response.body.isNotEmpty
                      ? json.decode(response.body)['message'] ??
                          'Registration failed'
                      : 'Registration failed';
                  await _showAlertErr(context, 'Error', errorMessage);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color.fromARGB(255, 8, 141, 39), // Solid color
                foregroundColor: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
              ),
              child: Text(
                'Register',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text(
                'Already have an account? Login',
                style: TextStyle(color: Color.fromARGB(255, 4, 153, 34)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    IconData? icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: icon != null
            ? Icon(icon, color: Color.fromARGB(255, 13, 171, 76))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
              color: Color.fromARGB(255, 18, 152, 8)), // Default border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide:
              BorderSide(color: Colors.green), // Border color when focused
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 251, 251, 251),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }

  Future<http.Response> _registerUser(
    String email,
    String password,
    String name,
  ) {
    return http.post(
      Uri.parse(
          'http://127.0.0.1:8000/api/register'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      }),
    );
  }

  Future<void> _showAlert(BuildContext context, String title, String message) {
    return Alert(
      context: context,
      type: AlertType.success,
      title: title,
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromARGB(255, 0, 179, 134),
        )
      ],
    ).show();
  }

  Future<void> _showAlertErr(
      BuildContext context, String title, String message) {
    return Alert(
      context: context,
      type: AlertType.error,
      title: title,
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromARGB(255, 0, 179, 134),
        )
      ],
    ).show();
  }

  void _showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(
                color: Color.fromARGB(255, 8, 141, 39), // Custom color
                strokeWidth: 6.0, // Custom stroke width
              ),
              SizedBox(width: 20),
              Text(
                "Processing...",
                style: TextStyle(
                  fontSize: 16, // Custom font size
                  color: Colors.black, // Custom text color
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _parseValidationErrors(Map<String, dynamic> responseData) {
    final StringBuffer errorMessages = StringBuffer();
    responseData.forEach((field, messages) {
      errorMessages
          .writeln('$field: ${List<String>.from(messages).join(', ')}');
    });
    return errorMessages.toString();
  }
}
