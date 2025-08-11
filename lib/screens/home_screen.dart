import 'package:desafio_code/widgets/character_list_screen.dart';
import 'package:desafio_code/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leftIcon: Icon(Icons.menu, color: Colors.white, size: 21),
      ),
      body: const ColoredBox(color: Colors.black, child: CharacterListScreen()),
    );
  }
}
