import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:nawah/core/erorr/failure.dart';
import 'package:nawah/core/utils/try_and_catch.dart';

import '../../../../core/utils/crud.dart';
import '../model/quiz_model.dart';

abstract class QuizzesRemoteDataSouce {
  // Future<Either<Failure, List<QuizModel>>> getQuizzes();
  // Future<Either<Failure, QuizModel>> addQuiz(QuizModel quiz);
}

class QuizzesRemoteDataSouceImpl extends QuizzesRemoteDataSouce {
  final Crud crud;

  QuizzesRemoteDataSouceImpl(this.crud);
  // @override
  // Future<Either<Failure, List<QuizModel>>> getQuizzes() {
  //  executeTryAndCatchForDataLayer((){
  //   return crud.postData(link: 'quizzes', data: {});
  // });
  // }

  // @override
  // Future<Either<Failure, QuizModel>> addQuiz(QuizModel quiz) {
  //   executeTryAndCatchForDataLayer(() {
  //     return crud.postData(link: 'quizzes', data: quiz.toJson());
  //   });
  // }
}
