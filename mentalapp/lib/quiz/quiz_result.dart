import 'package:flutter/material.dart';
import 'quiz_data.dart';
import 'quiz_home.dart';

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final int passingScore;
  final String levelName;
  final List<Question> questions;
  final List<int?> selectedAnswers;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.passingScore,
    required this.levelName,
    required this.questions,
    required this.selectedAnswers,
  });

  bool get hasPassed => score >= passingScore;
  double get percentage => (score / totalQuestions) * 100;

  String _getCongratulatoryMessage() {
    if (percentage == 100) {
      return 'Perfect! You\'re a genius!';
    } else if (percentage >= 80) {
      return 'Excellent work! Outstanding performance!';
    } else if (percentage >= 60) {
      return 'Good job! Keep practicing!';
    } else if (percentage >= 40) {
      return 'Nice try! You can do better!';
    } else {
      return 'Keep learning! Practice makes perfect!';
    }
  }

  String _getEmoji() {
    if (percentage == 100) {
      return 'trophy';
    } else if (percentage >= 80) {
      return 'stars';
    } else if (percentage >= 60) {
      return 'thumb_up';
    } else if (percentage >= 40) {
      return 'sentiment_satisfied';
    } else {
      return 'school';
    }
  }

  String _getMotivationalAdvice() {
    if (hasPassed) {
      // Motivational advice for those who passed
      if (percentage == 100) {
        return 'Unbelievable! You have mastered this topic perfectly. Your understanding of mental health is exceptional. Keep sharing your knowledge with others!';
      } else if (percentage >= 80) {
        return 'Excellent work! You have a strong grasp of mental health concepts. Your dedication to learning is inspiring. Continue this great journey!';
      } else if (percentage >= 70) {
        return 'Well done! You understand mental health well. Every step you take to learn more makes a difference. Keep growing and helping others!';
      } else {
        return 'Good job! You passed and that\'s what matters. Learning about mental health is a journey, and you\'re on the right path!';
      }
    } else {
      // Encouraging advice for those who didn't pass (without saying "failed")
      if (percentage >= 50) {
        return 'You\'re so close! Your effort shows you care about mental health. Keep learning - every question teaches you something valuable. You\'ll get there!';
      } else if (percentage >= 30) {
        return 'Learning takes time, and you\'re taking important steps! Mental health is complex, but your interest shows you want to help. Keep going, you\'re doing great!';
      } else {
        return 'Every journey begins with a single step! You\'re brave to learn about mental health. Each try makes you stronger. We believe in you - keep trying!';
      }
    }
  }

  String _getMotivationalTitle() {
    if (hasPassed) {
      return 'Congratulations!';
    } else {
      return 'Keep Learning!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Quiz Result'),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Result Card
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: hasPassed
                        ? [const Color(0xFF667EEA), const Color(0xFF764BA2)]
                        : [Colors.grey[400]!, Colors.grey[600]!],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Trophy/Icon
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        _getEmoji() == 'trophy'
                            ? Icons.emoji_events
                            : _getEmoji() == 'stars'
                                ? Icons.star
                                : _getEmoji() == 'thumb_up'
                                    ? Icons.thumb_up
                                    : _getEmoji() == 'sentiment_satisfied'
                                        ? Icons.sentiment_satisfied
                                        : Icons.school,
                        size: 60,
                        color: hasPassed
                            ? const Color(0xFF667EEA)
                            : Colors.grey[600],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Motivational Title
                    Text(
                      _getMotivationalTitle(),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      _getCongratulatoryMessage(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),

                    // Score Display
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '$score/$totalQuestions',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: hasPassed
                                  ? const Color(0xFF667EEA)
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${percentage.toStringAsFixed(0)}%',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: hasPassed
                                  ? const Color(0xFF667EEA)
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            hasPassed ? 'PASSED' : 'KEEP PRACTICING',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: hasPassed ? Colors.green : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Level Info
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quiz Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Level:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF718096),
                          ),
                        ),
                        Text(
                          'Quiz Level',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Passing Score:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF718096),
                          ),
                        ),
                        Text(
                          '$passingScore/$totalQuestions',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Correct Answers:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF718096),
                          ),
                        ),
                        Text(
                          '$score questions',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Motivational Advice Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: hasPassed
                        ? [const Color(0xFF667EEA).withOpacity(0.1), const Color(0xFF764BA2).withOpacity(0.1)]
                        : [Colors.orange.withOpacity(0.1), Colors.amber.withOpacity(0.1)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: hasPassed ? const Color(0xFF667EEA).withOpacity(0.3) : Colors.orange.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          hasPassed ? Icons.psychology : Icons.lightbulb,
                          color: hasPassed ? const Color(0xFF667EEA) : Colors.orange,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          hasPassed ? 'Mental Health Insight' : 'Encouragement',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: hasPassed ? const Color(0xFF667EEA) : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _getMotivationalAdvice(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF2D3748),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  // Review Answers Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _showReviewDialog(context);
                      },
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
                        'Review Answers',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Back to Levels Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuizHomeScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF667EEA),
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Back to Levels',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Return to Home Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizHomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF764BA2),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Return to Home',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Answer Review'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              final selectedAnswer = selectedAnswers[index];
              final isCorrect = selectedAnswer == question.correctAnswerIndex;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isCorrect ? Colors.green[50] : Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isCorrect ? Colors.green : Colors.red,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Q${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isCorrect ? Icons.check_circle : Icons.cancel,
                          color: isCorrect ? Colors.green : Colors.red,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (selectedAnswer != null) ...[
                      Text(
                        'Your answer: ${question.options[selectedAnswer]}',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              isCorrect ? Colors.green[700] : Colors.red[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ] else ...[
                      const Text(
                        'Not answered',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    if (!isCorrect) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Correct answer: ${question.options[question.correctAnswerIndex]}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      question.explanation,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF718096),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
