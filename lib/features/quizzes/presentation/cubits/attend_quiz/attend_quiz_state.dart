import '../../../data/model/quiz_model.dart';
import '../../../data/model/quiz_submission_response.dart';

enum AttendQuizStatus {
  initial,
  loading,
  loaded,
  submitting,
  submitted,
  error,
}

class AttendQuizState {
  final AttendQuizStatus status;
  final List<QuizModel>? quizzes;
  final String? errorMessage;
  final QuizSubmissionResponse? submissionResponse;

  const AttendQuizState({
    required this.status,
    this.quizzes,
    this.errorMessage,
    this.submissionResponse,
  });

  factory AttendQuizState.initial() => const AttendQuizState(
        status: AttendQuizStatus.initial,
      );

  AttendQuizState copyWith({
    AttendQuizStatus? status,
    List<QuizModel>? quizzes,
    String? errorMessage,
    QuizSubmissionResponse? submissionResponse,
  }) {
    return AttendQuizState(
      status: status ?? this.status,
      quizzes: quizzes ?? this.quizzes,
      errorMessage: errorMessage ?? this.errorMessage,
      submissionResponse: submissionResponse ?? this.submissionResponse,
    );
  }

  bool get isInitial => status == AttendQuizStatus.initial;
  bool get isLoading => status == AttendQuizStatus.loading;
  bool get isLoaded => status == AttendQuizStatus.loaded;
  bool get isSubmitting => status == AttendQuizStatus.submitting;
  bool get isSubmitted => status == AttendQuizStatus.submitted;
  bool get isError => status == AttendQuizStatus.error;
}
