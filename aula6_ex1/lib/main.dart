// The user will see this code block
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GridView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GridViewPage(),
    );
  }
}

class GridViewPage extends StatelessWidget {
  const GridViewPage({super.key});

  // Lista de dados para a grade
  final List<Map<String, String>> gridItems = const [
    {
      'image': 'https://images.unsplash.com/photo-1736957764199-8b3f7b6c117d?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Ingmar',
    },
    {
      'image': 'https://images.unsplash.com/photo-1758461479768-bdbce375e005?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Jonatan Pie',
    },
    {
      'image': 'https://images.unsplash.com/photo-1758407909328-6b46fbfc5f98?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Luke Peterson',
    },
    {
      'image': 'https://images.unsplash.com/photo-1749680920901-03fd16468019?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Philip Orani',
    },
    {
      'image': 'https://images.unsplash.com/photo-1750494733502-30427edd0efc?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Red Zeppelin',
    },
    {
      'image': 'https://images.unsplash.com/photo-1751182782142-000e62239d85?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Zulian Firmansyah',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView Example'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Número de colunas na grade
        crossAxisSpacing: 10, // Espaço horizontal entre os itens
        mainAxisSpacing: 10, // Espaço vertical entre os itens
        padding: const EdgeInsets.all(10), // Preenchimento ao redor da grade
        children: gridItems.map((item) {
          return Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Imagem de fundo
                Image.network(
                  item['image']!,
                  fit: BoxFit.cover,
                ),
                // Gradiente e texto sobre a imagem
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(),
                      ],
                    ),
                  ),
                  child: Text(
                    item['title']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}