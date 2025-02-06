import 'package:bloc/bloc.dart';
import 'package:nawah/features/quizzes/presentation/cubits/add_quiz_state.dart';

import '../../../data/model/quiz_model.dart';
import '../../../data/repository/quizzes_repository.dart';

class AddQuizCubit extends Cubit<AddQuizCubitState> {
  AddQuizCubit(this.quizzesRepository)
      : super(AddQuizCubitState(state: AddQuizState.initial, quiz: null));

  final QuizzesRepository quizzesRepository;

  Future<void> addQuiz(QuizModel quiz) async {
    emit(state.copyWith(state: AddQuizState.loading));
    print('Cubit: Adding quiz');
    final result = await quizzesRepository.addQuiz(quiz);
    result.fold(
      (failure) {
        print('Cubit: Failed to add quiz - ${failure.message}');
        emit(state.copyWith(
          state: AddQuizState.failure,
          errorMessage: failure.message,
        ));
      },
      (quiz) {
        print('Cubit: Successfully added quiz');
        emit(state.copyWith(
          state: AddQuizState.success,
          quiz: quiz,
        ));
      },
    );
  }
}
