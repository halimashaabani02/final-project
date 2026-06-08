import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MindcareGame extends StatefulWidget {
  const MindcareGame({super.key});

  @override
  State<MindcareGame> createState() => _MindcareGameState();
}

class _MindcareGameState extends State<MindcareGame> {
  final List<String> motivationalWords = [
    'HOPE',
    'PEACE',
    'LOVE',
    'CARE',
    'HEAL',
    'CALM',
    'JOY',
    'BRAVE',
    'STRONG',
    'HAPPY'
  ];

  String currentWord = '';
  List<String> shuffledPieces = [];
  List<String> arrangedPieces = [];
  List<String> correctPieces = [];
  bool isCompleted = false;
  int score = 0;
  List<String> completedWords = [];
  List<String> availableWords = [];

  @override
  void initState() {
    super.initState();
    _loadCompletedWords();
  }

  Future<void> _loadCompletedWords() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList('completed_words') ?? [];
    setState(() {
      completedWords = completed;
      availableWords = motivationalWords.where((word) => !completedWords.contains(word)).toList();
      if (availableWords.isEmpty) {
        // If all words are completed, reset and start over
        completedWords.clear();
        availableWords = List.from(motivationalWords);
        _saveCompletedWords();
      }
      _initializeNewWord();
    });
  }

  Future<void> _saveCompletedWords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('completed_words', completedWords);
  }

  void _initializeNewWord() {
    if (availableWords.isEmpty) {
      // If no available words, reset from all words
      completedWords.clear();
      availableWords = List.from(motivationalWords);
    }
    
    if (availableWords.isNotEmpty) {
      final randomIndex = Random().nextInt(availableWords.length);
      currentWord = availableWords[randomIndex];
      correctPieces = currentWord.split('');
      shuffledPieces = List.from(correctPieces)..shuffle(Random());
      arrangedPieces = List.filled(correctPieces.length, '');
      isCompleted = false;
    }
  }

  void _movePiece(int fromIndex, int toIndex) {
    if (toIndex < arrangedPieces.length && 
        arrangedPieces[toIndex].isEmpty && 
        fromIndex < shuffledPieces.length) {
      setState(() {
        arrangedPieces[toIndex] = shuffledPieces[fromIndex];
        shuffledPieces.removeAt(fromIndex);
        _checkCompletion();
      });
    }
  }

  void _returnPiece(int fromIndex) {
    if (fromIndex < arrangedPieces.length && arrangedPieces[fromIndex].isNotEmpty) {
      setState(() {
        shuffledPieces.add(arrangedPieces[fromIndex]);
        arrangedPieces[fromIndex] = '';
        shuffledPieces.shuffle(Random());
      });
    }
  }

  void _checkCompletion() {
    if (arrangedPieces.isNotEmpty && arrangedPieces.every((piece) => piece.isNotEmpty)) {
      String arrangedWord = arrangedPieces.join('');
      if (arrangedWord == currentWord) {
        setState(() {
          isCompleted = true;
          score += 10;
          completedWords.add(currentWord);
          availableWords.remove(currentWord);
        });
        _saveCompletedWords();
        _showCompletionDialog();
      }
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excellent! 🎉'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('You arranged: $currentWord'),
              const SizedBox(height: 8),
              const Text('Great job organizing your thoughts!'),
              const SizedBox(height: 8),
              Text('Score: $score'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nextWord();
              },
              child: const Text('Next Word'),
            ),
          ],
        );
      },
    );
  }

  void _nextWord() {
    setState(() {
      if (availableWords.isNotEmpty) {
        _initializeNewWord(); // This will select a random word
      } else {
        // All words completed, show completion message
        _showAllWordsCompletedDialog();
      }
    });
  }

  void _resetCurrentWord() {
    setState(() {
      _initializeNewWord();
    });
  }

  void _showAllWordsCompletedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('🎉 Congratulations!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('You have completed all the words!'),
              const SizedBox(height: 8),
              const Text('Great job on your mental health journey!'),
              const SizedBox(height: 8),
              Text('Final Score: $score'),
              const SizedBox(height: 8),
              const Text('Words will reset for your next session.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to mini games
              },
              child: const Text('Back to Games'),
            ),
          ],
        );
      },
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Mindcare Game'),
          content: Text('Are you sure you want to exit? Your current score is $score.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to mini games
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindcare Puzzle'),
        backgroundColor: const Color(0xFF667EEA),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _showExitDialog,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Score: $score',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.withOpacity(0.1),
              Colors.pink.withOpacity(0.1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              // Maelekezo ya mchezo
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple.withOpacity(0.3)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jinsi ya Kucheza:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Chukua sehemu za maneno kutoka juu\n• Weka sehemu kwenye nafasi sahihi\n• Panga maneno yote kwa mpangilio sahihi\n• Pata maneno ya kutia moyo kushinda',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              // Instructions
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Panga sehemu kuunda neno:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF667EEA),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Word length: ${currentWord.isNotEmpty ? currentWord.length : 0} letters',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Target slots
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF667EEA), width: 2),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Arrange Here:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF667EEA),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: correctPieces.isNotEmpty 
                          ? List.generate(
                              correctPieces.length,
                              (index) => _buildTargetSlot(index),
                            )
                          : [],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Shuffled pieces
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Available Pieces:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF667EEA),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: shuffledPieces.isNotEmpty 
                          ? List.generate(
                              shuffledPieces.length,
                              (index) => _buildDraggablePiece(index),
                            )
                          : [],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Control buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _resetCurrentWord,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Reset Word',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isCompleted ? _nextWord : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Next Word',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTargetSlot(int index) {
    if (index < 0 || index >= correctPieces.length) {
      return const SizedBox.shrink();
    }
    
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return GestureDetector(
          onTap: () {
            if (index < arrangedPieces.length && arrangedPieces[index].isNotEmpty) {
              _returnPiece(index);
            }
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: index < arrangedPieces.length && arrangedPieces[index].isEmpty 
                  ? Colors.grey[200] 
                  : const Color(0xFF667EEA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: index < arrangedPieces.length && arrangedPieces[index].isEmpty 
                    ? Colors.grey 
                    : const Color(0xFF667EEA),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                index < arrangedPieces.length ? arrangedPieces[index] : '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: index < arrangedPieces.length && arrangedPieces[index].isEmpty 
                      ? Colors.grey 
                      : Colors.white,
                ),
              ),
            ),
          ),
        );
      },
      onAccept: (data) {
        if (index < arrangedPieces.length && arrangedPieces[index].isEmpty) {
          int pieceIndex = shuffledPieces.indexOf(data);
          if (pieceIndex != -1) {
            _movePiece(pieceIndex, index);
          }
        }
      },
    );
  }

  Widget _buildDraggablePiece(int index) {
    if (index < 0 || index >= shuffledPieces.length) {
      return const SizedBox.shrink();
    }
    
    return Draggable<String>(
      data: shuffledPieces[index],
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.purple[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.purple, width: 2),
          ),
          child: Center(
            child: Text(
              shuffledPieces[index],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF667EEA),
              ),
            ),
          ),
        ),
      ),
      childWhenDragging: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.purple.withOpacity(0.5), width: 2),
        ),
        child: Center(
          child: Text(
            shuffledPieces[index],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF667EEA),
            ),
          ),
        ),
      ),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.purple[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.purple, width: 2),
        ),
        child: Center(
          child: Text(
            shuffledPieces[index],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF667EEA),
            ),
          ),
        ),
      ),
    );
  }
}
