import 'package:flutter/material.dart';
import 'package:aula7/post_model.dart';
import 'package:aula7/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter HTTP Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService _apiService = ApiService();
  String _statusMessage = 'Pressione um botão para realizar uma operação.';
  List<Post> _posts = [];
  bool _isLoading = false;

  Future<void> _runOperation(Future<void> Function() operation) async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Carregando...';
      _posts.clear();
    });
    try {
      await operation();
    } catch (e) {
      setState(() {
        _statusMessage = 'Erro: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _getPosts() => _runOperation(() async {
        final posts = await _apiService.fetchPosts();
        setState(() {
          _posts = posts;
          _statusMessage = 'Lista de ${posts.length} posts carregada com sucesso!';
        });
      });

  void _getPostById() => _runOperation(() async {
        final post = await _apiService.fetchPost(1); // Exemplo com ID 1
        setState(() {
          _posts.add(post);
          _statusMessage = 'Post com ID 1 carregado com sucesso!';
        });
      });

  void _createPost() => _runOperation(() async {
        final newPost = Post(
          userId: 1,
          title: 'Título de Teste',
          body: 'Corpo da mensagem de teste.',
        );
        final createdPost = await _apiService.createPost(newPost);
        setState(() {
          _statusMessage = 'Post criado com sucesso! ID: ${createdPost.id}';
        });
      });

  void _updatePost() => _runOperation(() async {
        final updatedPostData = Post(
          id: 1,
          userId: 1,
          title: 'Título Atualizado',
          body: 'Corpo da mensagem atualizada.',
        );
        final post = await _apiService.updatePost(1, updatedPostData);
        setState(() {
          _statusMessage = 'Post com ID ${post.id} atualizado com sucesso!';
        });
      });

  void _deletePost() => _runOperation(() async {
        await _apiService.deletePost(1); // Exemplo com ID 1
        setState(() {
          _statusMessage = 'Post com ID 1 deletado com sucesso!';
        });
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cliente HTTP Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(onPressed: _isLoading ? null : _getPosts, child: const Text('GET (Lista)')),
                ElevatedButton(onPressed: _isLoading ? null : _getPostById, child: const Text('GET (ID: 1)')),
                ElevatedButton(onPressed: _isLoading ? null : _createPost, child: const Text('POST')),
                ElevatedButton(onPressed: _isLoading ? null : _updatePost, child: const Text('PUT (ID: 1)')),
                ElevatedButton(onPressed: _isLoading ? null : _deletePost, child: const Text('DELETE (ID: 1)')),
              ],
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Text(
                    _statusMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
            const Divider(height: 30),
            Expanded(
              child: _posts.isEmpty
                  ? const Center(child: Text('Nenhum dado para exibir.'))
                  : ListView.builder(
                      itemCount: _posts.length,
                      itemBuilder: (context, index) {
                        final post = _posts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(child: Text(post.id.toString())),
                            title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(post.body),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}