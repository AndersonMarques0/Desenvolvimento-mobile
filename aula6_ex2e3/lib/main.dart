import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Tema',
      theme: ThemeData(
        // Tema principal com cor de fundo do Scaffold azul
        scaffoldBackgroundColor: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // O Theme aninhado sobrescreve a cor de fundo para amarelo
        child: Theme(
          data: ThemeData(
            scaffoldBackgroundColor: Colors.yellow,
          ),
          child: Builder(
            builder: (BuildContext innerContext) {
              return Scaffold(
                backgroundColor: Theme.of(innerContext).scaffoldBackgroundColor,
              );
            },
          ),
        ),
      ),
    );
  }
}
