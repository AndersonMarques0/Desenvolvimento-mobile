import 'package:flutter/material.dart';

class MyMenuBar extends StatelessWidget implements PreferredSizeWidget {
  const MyMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Flutter is Fun'),
      backgroundColor: Colors.green,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
