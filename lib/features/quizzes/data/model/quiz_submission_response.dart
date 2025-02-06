class QuizSubmissionResponse {
  final String message;
  final int score;
  final int correctAnswers;
  final int totalQuestions;
  final int attemptId;

  QuizSubmissionResponse({
    required this.message,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.attemptId,
  });

  factory QuizSubmissionResponse.fromMap(Map<String, dynamic> map) {
    return QuizSubmissionResponse(
      message: map['message'] ?? '',
      score: map['score']?.toInt() ?? 0,
      correctAnswers: map['correct_answers']?.toInt() ?? 0,
      totalQuestions: map['total_questions']?.toInt() ?? 0,
      attemptId: map['attempt_id']?.toInt() ?? 0,
    );
  }
}
