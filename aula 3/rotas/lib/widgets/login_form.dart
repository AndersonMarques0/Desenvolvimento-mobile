import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha e-mail e senha.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      print('[login_form] Tentando fazer login com FirebaseAuth...');
      
      final UserCredential userCredential = 
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('[login_form] Login bem-sucedido! Usuário: ${userCredential.user?.uid}');

      // Navega imediatamente após o sign-in bem-sucedido.
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');

      // Em segundo plano: tenta salvar um log no Firestore, mas não bloqueia
      // a navegação caso a escrita falhe (por exemplo, por regras de segurança).
      FirebaseFirestore.instance.collection('login_logs').add({
        'userId': userCredential.user?.uid,
        'email': email,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((_) {
        // ignore: avoid_print
        print('[login_form] Log salvo no Firestore');
      }).catchError((e) {
        // ignore: avoid_print
        print('[login_form] Falha ao salvar log no Firestore: $e');
      });

    } on FirebaseAuthException catch (e) {
      print('[login_form] Erro de FirebaseAuth: ${e.code}');
      String errorMessage = 'Ocorreu um erro no login.';
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        errorMessage = 'E-mail ou senha inválidos.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'E-mail ou senha inválidos.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'O formato do e-mail é inválido.';
      }
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print('[login_form] Erro geral: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: $e'),
          backgroundColor: Colors.red,
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
          child: ElevatedButton(
            onPressed: _isLoading
                ? null
                : () {
                    setState(() => _isLoading = true);
                    _login().whenComplete(() {
                      if (mounted) setState(() => _isLoading = false);
                    });
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 114, 154, 223),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
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
