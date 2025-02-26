import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';
import 'hangman_painter.dart';

class AdminScreen extends StatefulWidget {
  final String playerName;

  const AdminScreen({super.key, required this.playerName});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> with WidgetsBindingObserver {
  final _wordController = TextEditingController();
  final _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _firebaseService.removePlayer(widget.playerName);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _firebaseService.removePlayer(widget.playerName);
    }
  }

  void _resetGame() async {
    await _firebaseService.gameRef.doc('current_game').update({
      'isActive': false,
      'guessedLetters': [],
      'failedAttempts': 0,
      'currentPlayer': '',
    });
  }

  void _skipTurn() async {
    final gameDoc = await _firebaseService.gameRef.doc('current_game').get();
    if (!gameDoc.exists) return;

    final gameData = gameDoc.data() as Map<String, dynamic>;
    final currentPlayer = gameData['currentPlayer'] as String;

    await _firebaseService.removePlayer(currentPlayer);

    final players = await _firebaseService.playersRef.get();
    if (players.docs.isEmpty) return;

    final currentPlayerIndex =
        players.docs.indexWhere((doc) => doc.get('name') == currentPlayer);
    final nextPlayerIndex = (currentPlayerIndex + 1) % players.docs.length;
    final nextPlayer = players.docs[nextPlayerIndex].get('name');

    await _firebaseService.gameRef.doc('current_game').update({
      'currentPlayer': nextPlayer,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hangman - Admin')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firebaseService.watchCurrentGame(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final gameData = snapshot.data?.data() as Map<String, dynamic>?;
          final isActive = gameData?['isActive'] ?? false;

          if (!isActive) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _wordController,
                    decoration: const InputDecoration(
                      labelText: 'Nueva palabra',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final word = _wordController.text.trim();
                      if (word.isNotEmpty) {
                        _firebaseService.startNewGame(word);
                        _wordController.clear();
                      }
                    },
                    child: const Text('Iniciar juego'),
                  ),
                ],
              ),
            );
          }

          final word = gameData!['word'] as String;
          final guessedLetters = List<String>.from(gameData['guessedLetters']);
          final failedAttempts = gameData['failedAttempts'] as int;
          final currentPlayer = gameData['currentPlayer'] as String;
          final maxAttempts = gameData['maxAttempts'] as int;

          final hasWon =
              word.split('').every((letter) => guessedLetters.contains(letter));
          final hasLost = failedAttempts >= maxAttempts;

          if (hasWon || hasLost) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(hasWon ? '¡Has ganado!' : '¡Has perdido!'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _firebaseService.startNewGame(word); // Reiniciar el juego
                    },
                    child: const Text('Reiniciar juego'),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Jugador actual: $currentPlayer'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _skipTurn,
                  child: const Text('Saltar turno'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _resetGame,
                  child: const Text('Reiniciar juego'),
                ),
                const SizedBox(height: 16),
                HangmanDrawing(failedAttempts: failedAttempts),
                const SizedBox(height: 16),
                Text(
                  word
                      .split('')
                      .map((letter) =>
                          guessedLetters.contains(letter) ? letter : '_')
                      .join(' '),
                  style: const TextStyle(fontSize: 24, letterSpacing: 4),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
