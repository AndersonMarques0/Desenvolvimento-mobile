import 'package:flutter/material.dart';
import 'package:rotas/screens/login_screen.dart';
import 'package:rotas/screens/home_screen.dart'; // Importe a tela de destino

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}