import 'dart:async';

import '../../../../core/constants/api_links.dart';
import '../../../../core/utils/crud.dart';
import '../../../../core/utils/try_and_catch.dart';
import '../model/quiz_model.dart';

abstract class QuizzesRemoteDataSouce {
  Future<Map<String, dynamic>> addQuiz(QuizModel quiz);
  Future<List<QuizModel>> getQuizzes(int teachingLevelId);
  Future<Map<String, dynamic>> submitQuiz(QuizSubmission submission);
}

class QuizzesRemoteDataSouceImpl extends QuizzesRemoteDataSouce {
  final Crud crud;

  QuizzesRemoteDataSouceImpl(this.crud);

  @override
  Future<List<QuizModel>> getQuizzes(int teachingLevelId) async {
    return executeTryAndCatchForDataLayer(() async {
      final response = await crud.getData(
        ApiLinks.getQuizzes,
        {'teaching_level_id': teachingLevelId},
      );
      final quizzesList = (response['quizzes'] as List)
          .map((quiz) => QuizModel.fromMap(quiz as Map<String, dynamic>))
          .toList();
      return quizzesList;
    });
  }

  @override
  Future<Map<String, dynamic>> submitQuiz(QuizSubmission submission) async {
    return executeTryAndCatchForDataLayer(() async {
      final response = await crud.postData(
        ApiLinks.submitQuiz,
        submission.toMap(),
      );
      return response as Map<String, dynamic>;
    });
  }

  @override
  Future<Map<String, dynamic>> addQuiz(QuizModel quiz) async {
    return executeTryAndCatchForDataLayer(() async {
      final response = await crud.postData(
        ApiLinks.addQuiz,
        quiz.toMap(),
      );
      return response as Map<String, dynamic>;
    });
  }
}
