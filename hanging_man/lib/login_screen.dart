import 'package:flutter/material.dart';

import 'admin_screen.dart';
import 'firebase_service.dart';
import 'player_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _firebaseService = FirebaseService();

  void _handleLogin() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    if (name != 'IVAADMIN') {
      await _firebaseService.upsertPlayer(name);
    }
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => name == 'IVAADMIN'
            ? AdminScreen(playerName: name)
            : PlayerScreen(playerName: name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hangman - Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
