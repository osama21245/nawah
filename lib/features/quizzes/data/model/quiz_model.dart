// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuizModel {
  final String id;
  final String title;
  final String description;
  final List<QuestionModel> questions;
  QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });

  QuizModel copyWith({
    String? id,
    String? title,
    String? description,
    List<QuestionModel>? questions,
  }) {
    return QuizModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  // factory QuizModel.fromMap(Map<String, dynamic> map) {
  //   return QuizModel(
  //     id: map['id'] as String,
  //     title: map['title'] as String,
  //     description: map['description'] as String,
  //     questions: List<QuestionModel>.from((map['questions'] as List<int>).map<QuestionModel>((x) => QuestionModel.fromMap(x as Map<String,dynamic>),),),
  //   );
  // }

  String toJson() => json.encode(toMap());

  //factory QuizModel.fromJson(String source) => QuizModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuizModel(id: $id, title: $title, description: $description, questions: $questions)';
  }

  @override
  bool operator ==(covariant QuizModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        listEquals(other.questions, questions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        questions.hashCode;
  }
}

class QuestionModel {
  final String id;
  final String question;
  final List<String> options;
  final String answer;
  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
  });

  QuestionModel copyWith({
    String? id,
    String? question,
    List<String>? options,
    String? answer,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'options': options,
      'answer': answer,
    };
  }

  // factory QuestionModel.fromMap(Map<String, dynamic> map) {
  //   return QuestionModel(
  //     id: map['id'] as String,
  //     question: map['question'] as String,
  //     options: List<String>.from((map['options'] as List<String>),
  //     // answer: map['answer'] as String,
  //   ));
  // }

  String toJson() => json.encode(toMap());

  // factory QuestionModel.fromJson(String source) => QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuestionModel(id: $id, question: $question, options: $options, answer: $answer)';
  }

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.question == question &&
        listEquals(other.options, options) &&
        other.answer == answer;
  }

  @override
  int get hashCode {
    return id.hashCode ^ question.hashCode ^ options.hashCode ^ answer.hashCode;
  }
}
