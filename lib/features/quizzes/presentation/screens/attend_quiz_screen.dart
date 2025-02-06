import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/crud.dart';
import '../../data/data_souce/quizzes_remote_data_souce.dart';
import '../../data/model/quiz_model.dart';
import '../../data/model/quiz_submission_response.dart';
import '../../data/repository/quizzes_repository.dart';
import '../cubits/attend_quiz/attend_quiz_cubit.dart';
import '../cubits/attend_quiz/attend_quiz_state.dart';
import 'package:dio/dio.dart';

class AttendQuizScreen extends StatelessWidget {
  final int studentId;

  const AttendQuizScreen({
    super.key,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Quizzes')),
      body: BlocBuilder<AttendQuizCubit, AttendQuizState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          if (state.isLoaded && state.quizzes != null) {
            return ListView.builder(
              itemCount: state.quizzes!.length,
              itemBuilder: (context, index) {
                final quiz = state.quizzes![index];
                return QuizCard(
                  quiz: quiz,
                  studentId: studentId,
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class QuizCard extends StatelessWidget {
  final QuizModel quiz;
  final int studentId;

  const QuizCard({
    super.key,
    required this.quiz,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizAttendPage(
                quiz: quiz,
                studentId: studentId,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quiz.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                quiz.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                '${quiz.questions.length} Questions',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizAttendPage extends StatelessWidget {
  final QuizModel quiz;
  final int studentId;

  const QuizAttendPage({
    super.key,
    required this.quiz,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendQuizCubit(
        QuizzesRepository(
          remoteDataSouce: QuizzesRemoteDataSouceImpl(
            Crud(dio: Dio()),
          ),
        ),
      ),
      child: BlocListener<AttendQuizCubit, AttendQuizState>(
        listener: (context, state) {
          if (state.isError) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.errorMessage ?? 'An error occurred'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }

          if (state.isSubmitted && state.submissionResponse != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuizResultScreen(
                  response: state.submissionResponse!,
                ),
              ),
            );
          }
        },
        child: BlocBuilder<AttendQuizCubit, AttendQuizState>(
          builder: (context, state) {
            if (state.isSubmitting) {
              return const Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Submitting your answers...'),
                    ],
                  ),
                ),
              );
            }

            return _QuizAttendView(
              quiz: quiz,
              studentId: studentId,
            );
          },
        ),
      ),
    );
  }
}

class QuizResultScreen extends StatelessWidget {
  final QuizSubmissionResponse response;

  const QuizResultScreen({
    super.key,
    required this.response,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  response.message,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  'Score: ${response.score}%',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  'Correct Answers: ${response.correctAnswers}/${response.totalQuestions}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Pop twice to go back to quiz list
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
                  child: const Text('Back to Quizzes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuizAttendView extends StatefulWidget {
  final QuizModel quiz;
  final int studentId;

  const _QuizAttendView({
    required this.quiz,
    required this.studentId,
  });

  @override
  State<_QuizAttendView> createState() => _QuizAttendViewState();
}

class _QuizAttendViewState extends State<_QuizAttendView> {
  final Map<int, int> selectedAnswers = {};

  void _submitQuiz() {
    if (selectedAnswers.length != widget.quiz.questions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please answer all questions before submitting'),
        ),
      );
      return;
    }

    final submission = QuizSubmission(
      quizId: int.parse(widget.quiz.id!),
      studentId: widget.studentId,
      answers: selectedAnswers.entries
          .map((e) => QuestionAnswer(
                questionId: e.key,
                answerId: e.value,
              ))
          .toList(),
    );

    context.read<AttendQuizCubit>().submitQuiz(submission);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: selectedAnswers.length / widget.quiz.questions.length,
            backgroundColor: Colors.grey[300],
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.quiz.questions.length,
        itemBuilder: (context, index) {
          final question = widget.quiz.questions[index];
          final questionId = int.parse(question.id!);
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${index + 1}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    question.questionText,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  ...question.answers.map((answer) {
                    final answerId = int.parse(answer.id!);
                    return RadioListTile<int>(
                      title: Text(answer.answerText),
                      value: answerId,
                      groupValue: selectedAnswers[questionId],
                      onChanged: (value) {
                        setState(() {
                          selectedAnswers[questionId] = value!;
                        });
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submitQuiz,
        label: const Text('Submit Quiz'),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
