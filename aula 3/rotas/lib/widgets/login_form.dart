// login-form.dart
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email == 'admin' && password == '1234') {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('E-mail ou senha incorretos.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 480,
          height: 50,
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "E-mail",
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 480,
          height: 50,
          child: TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Password",
            ),
            obscureText: true,
          ),
        ),
        const SizedBox(height: 10),
        const SizedBox(
          width: 140,
          height: 50,
          child: Text('Esqueceu a senha?'),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 180,
          height: 50,
          child: FloatingActionButton(
            onPressed: _login,
            backgroundColor: const Color.fromARGB(255, 114, 154, 223),
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}