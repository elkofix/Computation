import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get gameRef => _firestore.collection('hangman_game');
  CollectionReference get playersRef => _firestore.collection('players');

  Future<void> checkGameStatus() async {
    final gameDoc = await gameRef.doc('current_game').get();
    if (!gameDoc.exists) return;

    final gameData = gameDoc.data() as Map<String, dynamic>;
    final word = gameData['word'] as String;
    final guessedLetters = List<String>.from(gameData['guessedLetters']);
    final failedAttempts = gameData['failedAttempts'] as int;
    final maxAttempts = gameData['maxAttempts'] as int;

    final hasWon =
        word.split('').every((letter) => guessedLetters.contains(letter));

    final hasLost = failedAttempts >= maxAttempts;

    if (hasWon || hasLost) {
      await gameRef.doc('current_game').update({
        'isActive': false,
        'guessedLetters': [],
        'failedAttempts': 0,
        'currentPlayer': '',
      });
    }
  }

  Future<void> upsertPlayer(String name) async {
    await playersRef.doc(name).set({
      'name': name,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removePlayer(String name) async {
    await playersRef.doc(name).delete();
  }

  Future<void> startNewGame(String word) async {
    final players = await playersRef.get();
    if (players.docs.isEmpty) return;

    final randomIndex =
        DateTime.now().millisecondsSinceEpoch % players.docs.length;
    final currentPlayer = players.docs[randomIndex].get('name');

    await gameRef.doc('current_game').set({
      'word': word.toUpperCase(),
      'guessedLetters': [],
      'failedAttempts': 0,
      'currentPlayer': currentPlayer,
      'isActive': true,
      'maxAttempts': 6,
    });
  }

  Future<void> makeGuess(String letter) async {
    final gameDoc = await gameRef.doc('current_game').get();
    if (!gameDoc.exists) return;

    final gameData = gameDoc.data() as Map<String, dynamic>;
    final word = gameData['word'] as String;
    final guessedLetters = List<String>.from(gameData['guessedLetters']);

    if (!guessedLetters.contains(letter.toUpperCase())) {
      guessedLetters.add(letter.toUpperCase());
      final failedAttempts = !word.contains(letter.toUpperCase())
          ? gameData['failedAttempts'] + 1
          : gameData['failedAttempts'];

      final players = await playersRef.get();
      final currentPlayerIndex = players.docs
          .indexWhere((doc) => doc.get('name') == gameData['currentPlayer']);
      final nextPlayerIndex = (currentPlayerIndex + 1) % players.docs.length;
      final nextPlayer = players.docs[nextPlayerIndex].get('name');

      await gameRef.doc('current_game').update({
        'guessedLetters': guessedLetters,
        'failedAttempts': failedAttempts,
        'currentPlayer': nextPlayer,
      });

      await checkGameStatus();
    }
  }

  Stream<DocumentSnapshot> watchCurrentGame() {
    return gameRef.doc('current_game').snapshots();
  }

  Stream<QuerySnapshot> watchPlayers() {
    return playersRef.snapshots();
  }
}
