import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  final List<String> _cardSymbols = [
    '❤️',
    '🌈',
    '🌸',
    '🦋',
    '🌺',
    '🌙',
  ];

  late List<CardModel> _cards;

  final List<CardModel> _flippedCards = [];

  bool _isChecking = false;
  int _moves = 0;
  int _matches = 0;
  bool _gameWon = false;

  Timer? _timer;
  int _timeLeft = 720;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initializeGame() {
    _timer?.cancel();

    final symbols = [..._cardSymbols, ..._cardSymbols];
    symbols.shuffle(Random());

    _cards = symbols.asMap().entries.map((entry) {
      return CardModel(
        id: entry.key,
        symbol: entry.value,
      );
    }).toList();

    _flippedCards.clear();
    _isChecking = false;
    _moves = 0;
    _matches = 0;
    _gameWon = false;
    _timeLeft = 720;

    setState(() {});

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_timeLeft > 0) {
          if (mounted) {
            setState(() {
              _timeLeft--;
            });
          }
        } else {
          _timer?.cancel();

          if (!_gameWon && mounted) {
            _showTimeUpDialog();
          }
        }
      },
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _onCardTap(CardModel card) {
    if (_isChecking || card.isFlipped || card.isMatched) {
      return;
    }

    setState(() {
      card.isFlipped = true;
      _flippedCards.add(card);
    });

    if (_flippedCards.length == 2) {
      _isChecking = true;
      _moves++;

      if (_flippedCards[0].symbol ==
          _flippedCards[1].symbol) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () {
            if (!mounted) return;

            setState(() {
              _flippedCards[0].isMatched = true;
              _flippedCards[1].isMatched = true;

              _matches++;

              _flippedCards.clear();
              _isChecking = false;

              if (_matches == _cardSymbols.length) {
                _gameWon = true;
                _timer?.cancel();
                _showWinDialog();
              }
            });
          },
        );
      } else {
        Future.delayed(
          const Duration(milliseconds: 800),
          () {
            if (!mounted) return;

            setState(() {
              _flippedCards[0].isFlipped = false;
              _flippedCards[1].isFlipped = false;

              _flippedCards.clear();
              _isChecking = false;
            });
          },
        );
      }
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text("Hongera 🎉"),
          content: Text(
            "Umeshinda!\n\nMoves: $_moves\nTime: ${_formatTime(720 - _timeLeft)}",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _initializeGame();
              },
              child: const Text("Cheza Tena"),
            ),
          ],
        );
      },
    );
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text("Muda Umekwisha ⏰"),
          content: const Text("Jaribu tena."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _initializeGame();
              },
              child: const Text("Jaribu Tena"),
            ),
          ],
        );
      },
    );
  }

  void _showExitDialog() {
    _timer?.cancel();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Exit Game"),
          content: const Text(
            "Una uhakika unataka kutoka kwenye mchezo?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _startTimer();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                "Exit",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStat(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Memory Game"),
        backgroundColor: Colors.green,

        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _showExitDialog,
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4),

          child: Column(
            children: [
              /// STATS
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 6,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 3,
                    ),
                  ],
                ),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround,

                  children: [
                    _buildStat("Moves", "$_moves"),
                    _buildStat("Matches", "$_matches/6"),
                    _buildStat(
                      "Time",
                      _formatTime(_timeLeft),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              /// HOW TO PLAY
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: const Color(0xFFEEDAF3),

                  borderRadius:
                      BorderRadius.circular(12),

                  border: Border.all(
                    color: Colors.purple.shade200,
                  ),
                ),

                child: const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Jinsi ya Kucheza:",

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      "• Bonyeza card mbili kufungua\n"
                      "• Tafuta emoji zinazofanana\n"
                      "• Ukipata zinazofanana zinabaki wazi\n"
                      "• Zisipo fanana zitafungwa tena\n"
                      "• Maliza zote kushinda mchezo 🎉",

                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// GRID
              Expanded(
                child: GridView.builder(
                  physics:
                      const NeverScrollableScrollPhysics(),

                  itemCount: _cards.length,

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,

                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,

                    childAspectRatio: 1.1,
                  ),

                  itemBuilder: (context, index) {
                    final card = _cards[index];

                    return GestureDetector(
                      onTap: () => _onCardTap(card),

                      child: AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 300),

                        decoration: BoxDecoration(
                          color: card.isFlipped ||
                                  card.isMatched
                              ? Colors.white
                              : Colors.green,

                          borderRadius:
                              BorderRadius.circular(10),

                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.08),
                              blurRadius: 2,
                            ),
                          ],
                        ),

                        child: Center(
                          child: card.isFlipped ||
                                  card.isMatched
                              ? Text(
                                  card.symbol,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              : const Icon(
                                  Icons.question_mark,
                                  color: Colors.white,
                                  size: 18,
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardModel {
  final int id;
  final String symbol;

  bool isFlipped;
  bool isMatched;

  CardModel({
    required this.id,
    required this.symbol,
    this.isFlipped = false,
    this.isMatched = false,
  });
}