import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "App de Notas de Tarefas",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TaskPage(),
    );
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<bool> taskStatus = List.generate(5, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kindacode.com"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Mostrar tarefas concluídas")),
              );
            },
            child: const Text("View Completed Tasks"),
          ),
          const SizedBox(height: 10),
          const Text(
            "You have 5 uncompleted tasks",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: taskStatus.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.yellow[100],
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: ListTile(
                    title: Text("Task ${DateTime.now()}"),
                    trailing: Checkbox(
                      value: taskStatus[index],
                      onChanged: (bool? value) {
                        setState(() {
                          taskStatus[index] = value ?? false;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("App de Notas de Tarefas"),
              content: const Text("Você está no App de Notas de Tarefas"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}