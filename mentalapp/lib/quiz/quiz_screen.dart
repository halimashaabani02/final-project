import 'package:flutter/material.dart';
import 'quiz_data.dart';
import 'quiz_result.dart';

class QuizScreen extends StatefulWidget {
  final QuizLevel level;

  const QuizScreen({super.key, required this.level});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  List<int?> selectedAnswers = [];
  bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(widget.level.questions.length, null);
  }

  List<Question> get shuffledQuestions {
    return QuizData.getShuffledQuestions(widget.level);
  }

  void _selectAnswer(int answerIndex) {
    if (!isSubmitted) {
      setState(() {
        selectedAnswers[currentQuestionIndex] = answerIndex;
      });
    }
  }

  void _nextQuestion() {
    if (currentQuestionIndex < shuffledQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _submitQuiz();
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void _submitQuiz() {
    setState(() {
      isSubmitted = true;
    });

    // Calculate score
    int score = 0;
    for (int i = 0; i < shuffledQuestions.length; i++) {
      if (selectedAnswers[i] == shuffledQuestions[i].correctAnswerIndex) {
        score++;
      }
    }

    // Navigate to result screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultScreen(
          score: score,
          totalQuestions: shuffledQuestions.length,
          passingScore: widget.level.passingScore,
          levelName: 'Quiz Level',
          questions: shuffledQuestions,
          selectedAnswers: selectedAnswers,
        ),
      ),
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Quiz'),
          content: const Text('Are you sure you want to exit this quiz? Your progress will be lost.'),
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
                Navigator.of(context).pop(); // Go back to quiz home
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
    final currentQuestion = shuffledQuestions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / shuffledQuestions.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Quiz Challenge'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            _showCancelDialog();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '${currentQuestionIndex + 1}/${shuffledQuestions.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Bar
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Question Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF667EEA),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    currentQuestion.question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Answer Options
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.options.length,
                itemBuilder: (context, index) {
                  final isSelected =
                      selectedAnswers[currentQuestionIndex] == index;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      onPressed: () => _selectAnswer(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected ? const Color(0xFF667EEA) : Colors.white,
                        foregroundColor:
                            isSelected ? Colors.white : const Color(0xFF2D3748),
                        elevation: isSelected ? 4 : 1,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected
                                ? const Color(0xFF667EEA)
                                : const Color(0xFFE2E8F0),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Option Letter
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withOpacity(0.2)
                                  : const Color(0xFFF5F7FA),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                String.fromCharCode(65 + index), // A, B, C, D
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF667EEA),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Option Text
                          Expanded(
                            child: Text(
                              currentQuestion.options[index],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          // Check Icon
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Navigation Buttons
            Row(
              children: [
                // Exit Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: _showCancelDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      foregroundColor: Colors.white,
                      elevation: 1,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Exit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Previous Button
                Expanded(
                  child: currentQuestionIndex > 0
                      ? ElevatedButton(
                          onPressed: _previousQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF667EEA),
                            elevation: 1,
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: Color(0xFF667EEA)),
                            ),
                          ),
                          child: const Text(
                            'Previous',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),

                if (currentQuestionIndex > 0) const SizedBox(width: 16),

                // Next/Submit Button
                Expanded(
                  flex: currentQuestionIndex > 0 ? 1 : 2,
                  child: ElevatedButton(
                    onPressed: selectedAnswers[currentQuestionIndex] != null
                        ? _nextQuestion
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF667EEA),
                      foregroundColor: Colors.white,
                      elevation: 2,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      currentQuestionIndex < shuffledQuestions.length - 1
                          ? 'Next'
                          : 'Submit',
                      style: const TextStyle(
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
    );
  }
}
