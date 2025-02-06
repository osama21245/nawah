import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/crud.dart';
import '../../../quizzes/data/data_souce/quizzes_remote_data_souce.dart';
import '../../../quizzes/data/repository/quizzes_repository.dart';
import '../../../quizzes/presentation/cubits/attend_quiz/attend_quiz_cubit.dart';
import '../../../quizzes/presentation/screens/attend_quiz_screen.dart';
import '../../data/models/teachers_model.dart';

class TeacherLevelsScreen extends StatelessWidget {
  final TeacherModel teacher;

  const TeacherLevelsScreen({
    super.key,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${teacher.name}\'s Levels'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: teacher.teachingLevels.length,
        itemBuilder: (context, index) {
          final level = teacher.teachingLevels[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => AttendQuizCubit(
                        QuizzesRepository(
                          remoteDataSouce: QuizzesRemoteDataSouceImpl(
                            Crud(dio: Dio()),
                          ),
                        ),
                      )..getQuizzes(int.parse(level.id)),
                      child: const AttendQuizScreen(studentId: 1),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                level.name,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                level.subject,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${level.price}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            if (level.discount != '0.00')
                              Text(
                                'Discount: \$${level.discount}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.green),
                              ),
                          ],
                        ),
                      ],
                    ),
                    if (level.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        level.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
