
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PoliBus"),
        backgroundColor: Colors.red,
      ),
      body: Padding
      (
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Bienvenido"),
          ],
        ),
      ),
    );
  }
  
}