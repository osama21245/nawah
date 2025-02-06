import 'dart:convert';

class QuizModel {
  final String? id;
  final String title;
  final String description;
  final String teacherId;
  final String? teachingLevelId;
  final TeachingLevel? teachingLevel;
  final List<QuestionModel> questions;
  final String? createdAt;
  final String? updatedAt;

  QuizModel({
    this.id,
    required this.title,
    required this.description,
    required this.teacherId,
    this.teachingLevelId,
    this.teachingLevel,
    required this.questions,
    this.createdAt,
    this.updatedAt,
  });

  // For sending to server (creating quiz)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'teacher_id': teacherId,
      'teaching_level_id': teachingLevelId,
      'questions': questions.map((q) => q.toMap()).toList(),
    };
  }

  // For receiving from server
  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      id: map['id']?.toString(),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      teacherId: map['teacher_id']?.toString() ?? '',
      teachingLevelId: map['teaching_level_id']?.toString(),
      teachingLevel: map['teaching_level'] != null
          ? TeachingLevel.fromMap(map['teaching_level'])
          : null,
      questions: (map['questions'] as List?)
              ?.map((q) => QuestionModel.fromMap(q as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}

class TeachingLevel {
  final int id;
  final String name;
  final String subject;

  TeachingLevel({
    required this.id,
    required this.name,
    required this.subject,
  });

  factory TeachingLevel.fromMap(Map<String, dynamic> map) {
    return TeachingLevel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      subject: map['subject'] ?? '',
    );
  }
}

class QuestionModel {
  final String? id;
  final String questionText;
  final List<AnswerModel> answers;

  QuestionModel({
    this.id,
    required this.questionText,
    required this.answers,
  });

  // For sending to server
  Map<String, dynamic> toMap() {
    return {
      'question_text': questionText,
      'answers': answers.map((a) => a.toMap()).toList(),
    };
  }

  // For receiving from server
  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id']?.toString(),
      questionText: map['question_text'] ?? '',
      answers: (map['answers'] as List?)
              ?.map((a) => AnswerModel.fromMap(a as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class AnswerModel {
  final String? id;
  final String answerText;
  final bool isCorrect;

  AnswerModel({
    this.id,
    required this.answerText,
    required this.isCorrect,
  });

  // For sending to server
  Map<String, dynamic> toMap() {
    return {
      'answer_text': answerText,
      'is_correct': isCorrect,
    };
  }

  // For receiving from server
  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      id: map['id']?.toString(),
      answerText: map['answer_text'] ?? '',
      isCorrect: map['is_correct'] == true || map['is_correct'] == 1,
    );
  }
}

// Add this new class for quiz submission
class QuizSubmission {
  final int quizId;
  final int studentId;
  final List<QuestionAnswer> answers;

  QuizSubmission({
    required this.quizId,
    required this.studentId,
    required this.answers,
  });

  Map<String, dynamic> toMap() {
    return {
      'quiz_id': quizId,
      'student_id': studentId,
      'answers': answers.map((answer) => answer.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}

class QuestionAnswer {
  final int questionId;
  final int answerId;

  QuestionAnswer({
    required this.questionId,
    required this.answerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'question_id': questionId,
      'answer_id': answerId,
    };
  }
}
