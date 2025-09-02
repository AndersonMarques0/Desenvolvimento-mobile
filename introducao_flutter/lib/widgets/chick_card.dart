import 'package:flutter/material.dart';

class ChickCard extends StatelessWidget {
  const ChickCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),        
      margin: const EdgeInsets.all(8),          
      decoration: BoxDecoration(
        color: Colors.red,                     
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,         
        children: const [
          SizedBox(width: 12),                  
          Text(
            "Hi, Mom!",
            style: TextStyle(
              color: Colors.white,             
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.egg,                          
            color: Colors.white,
            size: 32,
          ),
        ],
      ),
    );
  }
}