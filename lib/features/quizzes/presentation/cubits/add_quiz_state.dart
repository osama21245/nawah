// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../data/model/quiz_model.dart';

enum AddQuizState {
  initial,
  loading,
  success,
  failure,
}

extension AddQuizStateExtension on AddQuizCubitState {
  bool isInitial() => state == AddQuizState.initial;
  bool isLoading() => state == AddQuizState.loading;
  bool isSuccess() => state == AddQuizState.success;
  bool isFailure() => state == AddQuizState.failure;
}

class AddQuizCubitState {
  final AddQuizState state;
  final QuizModel? quiz;
  final String? errorMessage;
  AddQuizCubitState({
    required this.state,
    this.quiz,
    this.errorMessage,
  });

  AddQuizCubitState copyWith({
    AddQuizState? state,
    QuizModel? quiz,
    String? errorMessage,
  }) {
    return AddQuizCubitState(
      state: state ?? this.state,
      quiz: quiz ?? this.quiz,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'AddQuizCubitState(state: $state, quiz: $quiz, errorMessage: $errorMessage)';

  @override
  bool operator ==(covariant AddQuizCubitState other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.quiz == quiz &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => state.hashCode ^ quiz.hashCode ^ errorMessage.hashCode;
}
