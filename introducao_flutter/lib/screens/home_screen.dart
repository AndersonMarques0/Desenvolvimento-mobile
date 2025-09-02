import 'package:flutter/material.dart';
import '../widgets/menu_bar.dart';
import '../widgets/chick_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyMenuBar(), // nossa menubar reutilizável
      body: Stack(
        children: [
          Positioned(
            top: 120,
            left: 80,
            child: ChickCard(),
          )
        ],
      )
    );
  }
}