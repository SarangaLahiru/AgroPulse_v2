import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Handle registration logic
                final response = await registerUser(
                  _emailController.text,
                  _passwordController.text,
                );

                if (response.statusCode == 201) {
                  // Registration successful, navigate to home
                  Navigator.pushNamed(context, '/home');
                } else {
                  // Show error message
                  final Map<String, dynamic> responseData =
                      json.decode(response.body);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text(
                          responseData['message'] ?? 'Registration failed'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<http.Response> registerUser(String email, String password) {
    return http.post(
      Uri.parse(
          'http://http://127.0.0.1:8000/api/register'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'password_confirmation': password,
      }),
    );
  }
}
