import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color.fromARGB(255, 20, 171, 3),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.jpeg',
                  height: 150,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 73, 183, 58),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: _emailController,
                  labelText: 'Email',
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
                    // Handle login logic
                    final response = await _loginUser(
                      _emailController.text,
                      _passwordController.text,
                    );

                    if (response.statusCode == 200) {
                      // Login successful
                      Navigator.pushNamed(context, '/home');
                    } else {
                      // Show error message
                      final Map<String, dynamic> responseData =
                          json.decode(response.body);
                      _showDialog(context, 'Error',
                          responseData['message'] ?? 'Login failed');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Color.fromARGB(255, 8, 141, 39),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'Don\'t have an account? Register',
                    style: TextStyle(color: Color.fromARGB(255, 4, 153, 34)),
                  ),
                ),
              ],
            ),
          ),
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
          borderSide: BorderSide(color: Color.fromARGB(255, 18, 152, 8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.green),
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 251, 251, 251),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }

  Future<http.Response> _loginUser(String email, String password) {
    return http.post(
      Uri.parse('http://127.0.0.1:8000/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
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
