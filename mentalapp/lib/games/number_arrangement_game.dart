import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class NumberArrangementGame extends StatefulWidget {
  const NumberArrangementGame({super.key});

  @override
  State<NumberArrangementGame> createState() =>
      _NumberArrangementGameState();
}

class _NumberArrangementGameState
    extends State<NumberArrangementGame> {

  List<int> tiles = [];

  int moves = 0;
  int secondsElapsed = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    _initializeGame();
    _startTimer();
  }

  // RANDOM GAME
  void _initializeGame() {

    tiles = [1, 2, 3, 4, 5, 6, 7, 8, 0];

    tiles.shuffle(Random());

    while (_isSolved()) {
      tiles.shuffle(Random());
    }

    moves = 0;

    setState(() {});
  }

  bool _isSolved() {

    List<int> correct = [
      1,
      2,
      3,
      4,
      0,
      5,
      6,
      7,
      8
    ];

    for (int i = 0; i < tiles.length; i++) {

      if (tiles[i] != correct[i]) {
        return false;
      }
    }

    return true;
  }

  // TIMER
  void _startTimer() {

    timer?.cancel();

    secondsElapsed = 0;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {

        setState(() {
          secondsElapsed++;
        });
      },
    );
  }

  @override
  void dispose() {

    timer?.cancel();

    super.dispose();
  }

  String _formatTime(int seconds) {

    final minutes = seconds ~/ 60;

    final secs = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  // MOVE TILE
  void _moveTile(int index) {

    int emptyIndex = tiles.indexOf(0);

    List<int> validMoves = [];

    // LEFT
    if (emptyIndex % 3 != 0) {
      validMoves.add(emptyIndex - 1);
    }

    // RIGHT
    if (emptyIndex % 3 != 2) {
      validMoves.add(emptyIndex + 1);
    }

    // TOP
    if (emptyIndex - 3 >= 0) {
      validMoves.add(emptyIndex - 3);
    }

    // BOTTOM
    if (emptyIndex + 3 < 9) {
      validMoves.add(emptyIndex + 3);
    }

    if (validMoves.contains(index)) {

      setState(() {

        int temp = tiles[index];

        tiles[index] = 0;

        tiles[emptyIndex] = temp;

        moves++;
      });

      _checkWin();
    }
  }

  // CHECK WIN
  void _checkWin() {

    List<int> correct = [
      1,
      2,
      3,
      4,
      0,
      5,
      6,
      7,
      8
    ];

    bool win = true;

    for (int i = 0; i < 9; i++) {

      if (tiles[i] != correct[i]) {
        win = false;
        break;
      }
    }

    if (win) {

      timer?.cancel();

      _showWinDialog();
    }
  }

  // WIN DIALOG
  void _showWinDialog() {

    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (context) {

        return AlertDialog(

          title: const Row(
            children: [

              Icon(
                Icons.emoji_events,
                color: Colors.purple,
              ),

              SizedBox(width: 8),

              Text('Hongera'),
            ],
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              const Text(
                'Umefanikiwa kupanga namba!',
              ),

              const SizedBox(height: 10),

              Text('Moves: $moves'),

              const SizedBox(height: 6),

              Text(
                'Time: ${_formatTime(secondsElapsed)}',
              ),
            ],
          ),

          actions: [

            TextButton(
              onPressed: () {

                Navigator.pop(context);

                _initializeGame();

                _startTimer();
              },

              child: const Text(
                'Cheza Tena',
              ),
            ),
          ],
        );
      },
    );
  }

  // INSTRUCTIONS
  Widget _buildInstructionBox() {

    return Container(

      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(10),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
          ),
        ],
      ),

      child: const Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Icon(
                Icons.info_outline,
                color: Colors.purple,
              ),

              SizedBox(width: 6),

              Text(
                'Jinsi ya Kucheza',

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Text(
            '• Gusa namba karibu na sehemu tupu kuisogeza.',
          ),

          SizedBox(height: 4),

          Text(
            '• Panga namba kama hivi:',
          ),

          SizedBox(height: 6),

          Text(
            '1 2 3\n4   5\n6 7 8',

            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFEEDCFF),

      appBar: AppBar(

        title: const Text(
          'Number Puzzle',
        ),

        centerTitle: true,

        backgroundColor: Colors.purple,

        foregroundColor: Colors.white,

        actions: [

          IconButton(
            onPressed: () {

              _initializeGame();

              _startTimer();
            },

            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: Center(

        child: SingleChildScrollView(

          child: Column(

            children: [

              // INSTRUCTIONS
              Padding(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                child: _buildInstructionBox(),
              ),

              // GAME CONTAINER
              Container(

                width: 260,

                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(

                  color: const Color(0xFF6A0DAD),

                  borderRadius:
                      BorderRadius.circular(12),

                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),

                child: Column(

                  mainAxisSize: MainAxisSize.min,

                  children: [

                    // TOP BAR
                    Container(

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                          6,
                        ),
                      ),

                      child: Row(

                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                        children: [

                          Text(
                            'Moves: $moves',

                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          Row(
                            children: [

                              const Icon(
                                Icons.timer,
                                size: 18,
                              ),

                              const SizedBox(
                                  width: 4),

                              Text(
                                _formatTime(
                                  secondsElapsed,
                                ),

                                style:
                                    const TextStyle(
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // GRID
                    GridView.builder(

                      shrinkWrap: true,

                      physics:
                          const NeverScrollableScrollPhysics(),

                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(

                        crossAxisCount: 3,

                        crossAxisSpacing: 6,

                        mainAxisSpacing: 6,
                      ),

                      itemCount: 9,

                      itemBuilder:
                          (context, index) {

                        bool isEmpty =
                            tiles[index] == 0;

                        return GestureDetector(

                          onTap: () {

                            _moveTile(index);
                          },

                          child: AnimatedContainer(

                            duration:
                                const Duration(
                              milliseconds: 200,
                            ),

                            decoration:
                                BoxDecoration(

                              color: isEmpty
                                  ? const Color(
                                      0xFF6A0DAD)
                                  : Colors.white,

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                8,
                              ),

                              border: Border.all(
                                color:
                                    Colors.purple,
                                width: 2,
                              ),

                              boxShadow: isEmpty
                                  ? []
                                  : [

                                      BoxShadow(
                                        color: Colors
                                            .black
                                            .withOpacity(
                                                0.1),

                                        blurRadius: 4,

                                        offset:
                                            const Offset(
                                                0, 2),
                                      ),
                                    ],
                            ),

                            child: Center(

                              child: isEmpty
                                  ? const SizedBox()
                                  : Text(

                                      '${tiles[index]}',

                                      style:
                                          const TextStyle(
                                        fontSize:
                                            30,

                                        fontWeight:
                                            FontWeight
                                                .bold,

                                        color:
                                            Colors.black,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}