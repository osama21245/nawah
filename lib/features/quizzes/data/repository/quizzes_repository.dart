import 'package:fpdart/fpdart.dart';

import '../../../../core/erorr/failure.dart';
import '../../../../core/utils/try_and_catch.dart';
import '../data_souce/quizzes_remote_data_souce.dart';
import '../model/quiz_model.dart';
import '../model/quiz_submission_response.dart';

class QuizzesRepository {
  final QuizzesRemoteDataSouce remoteDataSouce;

  QuizzesRepository({required this.remoteDataSouce});

  Future<Either<Failure, QuizModel>> addQuiz(QuizModel quiz) async {
    return executeTryAndCatchForRepository(() async {
      final response = await remoteDataSouce.addQuiz(quiz);
      // The response contains the quiz data in a nested structure
      return QuizModel.fromMap(response['quiz'] as Map<String, dynamic>);
    });
  }

  Future<Either<Failure, List<QuizModel>>> getQuizzes(
      int teachingLevelId) async {
    return executeTryAndCatchForRepository(() async {
      return await remoteDataSouce.getQuizzes(teachingLevelId);
    });
  }

  Future<Either<Failure, QuizSubmissionResponse>> submitQuiz(
    QuizSubmission submission,
  ) async {
    return executeTryAndCatchForRepository(() async {
      final response = await remoteDataSouce.submitQuiz(submission);
      return QuizSubmissionResponse.fromMap(response);
    });
  }
}
