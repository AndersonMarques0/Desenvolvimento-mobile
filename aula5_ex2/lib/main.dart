import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BottomAppBar with FAB',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _showOptions = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleOptions() {
    setState(() {
      _showOptions = !_showOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BottomAppBar with FAB")),
      body: Center(
        child: Text(
          "TAB: $_selectedIndex",
          style: const TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Mini FABs sobem exatamente acima do botão principal
          if (_showOptions)
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  mini: true,
                  heroTag: "opt1",
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Opção 1 selecionada")),
                    );
                  },
                  child: const Icon(Icons.insert_drive_file),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  mini: true,
                  heroTag: "opt2",
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Opção 2 selecionada")),
                    );
                  },
                  child: const Icon(Icons.email),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  mini: true,
                  heroTag: "opt3",
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Opção 3 selecionada")),
                    );
                  },
                  child: const Icon(Icons.phone),
                ),
                const SizedBox(height: 70), // espaço para não sobrepor o FAB principal
              ],
            ),

          // FAB principal (fixo)
          FloatingActionButton(
            onPressed: _toggleOptions,
            child: Icon(_showOptions ? Icons.close : Icons.add),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: const Icon(Icons.layers),
              onPressed: () => _onItemTapped(1),
            ),
            const SizedBox(width: 40), // espaço pro FAB
            IconButton(
              icon: const Icon(Icons.dashboard),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}