import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/quiz_model.dart';
import '../../../data/repository/quizzes_repository.dart';
import 'attend_quiz_state.dart';

class AttendQuizCubit extends Cubit<AttendQuizState> {
  final QuizzesRepository _repository;

  AttendQuizCubit(this._repository) : super(AttendQuizState.initial());

  Future<void> getQuizzes(int teachingLevelId) async {
    emit(state.copyWith(status: AttendQuizStatus.loading));

    final result = await _repository.getQuizzes(teachingLevelId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: AttendQuizStatus.error,
        errorMessage: failure.message,
      )),
      (quizzes) => emit(state.copyWith(
        status: AttendQuizStatus.loaded,
        quizzes: quizzes,
      )),
    );
  }

  Future<void> submitQuiz(QuizSubmission submission) async {
    emit(state.copyWith(status: AttendQuizStatus.submitting));

    final result = await _repository.submitQuiz(submission);
    result.fold(
      (failure) => emit(state.copyWith(
        status: AttendQuizStatus.error,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: AttendQuizStatus.submitted,
        submissionResponse: response,
      )),
    );
  }
}
