import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

class PlayerScreen extends StatefulWidget {
  final String playerName;

  const PlayerScreen({super.key, required this.playerName});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with WidgetsBindingObserver {
  final _firebaseService = FirebaseService();
  final List<String> alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  String? selectedLetter;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hangman - Jugador')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firebaseService.watchCurrentGame(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final gameData = snapshot.data?.data() as Map<String, dynamic>?;
          final isActive = gameData?['isActive'] ?? false;

          if (!isActive) {
            return const Center(
              child: Text('Esperando que el admin inicie el juego...'),
            );
          }

          final word = gameData!['word'] as String;
          final guessedLetters = List<String>.from(gameData['guessedLetters']);
          final failedAttempts = gameData['failedAttempts'] as int;
          final maxAttempts = gameData['maxAttempts'] as int;
          final currentPlayer = gameData['currentPlayer'] as String;
          final isMyTurn = currentPlayer == widget.playerName;

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
                      _firebaseService.startNewGame(word);
                    },
                    child: const Text('Reiniciar juego'),
                  ),
                ],
              ),
            );
          }

          if (!isMyTurn) {
            return Center(
              child: Text('Es el turno de: $currentPlayer'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('¡Es tu turno!', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: alphabet.map((letter) {
                    final isLetterGuessed = guessedLetters.contains(letter);
                    return ElevatedButton(
                      onPressed: isLetterGuessed
                          ? null
                          : () {
                              setState(() {
                                selectedLetter = letter;
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedLetter == letter
                            ? Colors.blue
                            : (isLetterGuessed ? Colors.grey : null),
                      ),
                      child: Text(letter),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: selectedLetter != null
                      ? () {
                          _firebaseService.makeGuess(selectedLetter!);
                          setState(() {
                            selectedLetter = null;
                          });
                        }
                      : null,
                  child: const Text('Enviar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
