import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('Create an Account'),
        backgroundColor: Color.fromARGB(255, 20, 171, 3),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
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
                color: const Color.fromARGB(255, 73, 183, 58),
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
                // Handle registration logic
                final response = await _registerUser(
                  _emailController.text,
                  _passwordController.text,
                  _nameController.text,
                );

                if (response.statusCode == 201) {
                  // Registration successful
                  _showDialog(
                      context, 'Success', 'Registration successful! Welcome.');
                  Navigator.pushNamed(context, '/home');
                } else {
                  // Show error message
                  final Map<String, dynamic> responseData =
                      json.decode(response.body);
                  _showDialog(context, 'Error',
                      responseData['message'] ?? 'Registration failed');
                }
              },
              style: ElevatedButton.styleFrom(
                // primary: Colors.deepPurple,

                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color.fromARGB(
                    255, 8, 141, 39), // Solid color instead of semi-transparent
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
        fillColor: Colors.grey[200],
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

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
