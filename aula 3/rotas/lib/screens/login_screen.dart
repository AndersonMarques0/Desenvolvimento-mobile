// login-screen.dart
import 'package:flutter/material.dart';
import 'package:rotas/widgets/login_form.dart'; // Importe o novo widget

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset('assets/images/android-logo.png'),
              ),
              const SizedBox(height: 20),
              const LoginForm(), // Use o widget reutilizável aqui
            ],
          ),
        ),
      ),
    );
  }
}