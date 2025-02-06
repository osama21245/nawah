import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/teachers_model.dart';
import '../cubits/home/home_cubit.dart';
import '../cubits/home/home_state.dart';
import 'teacher_levels_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          if (state.isLoaded && state.teachers != null) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.teachers!.length,
              itemBuilder: (context, index) {
                final teacher = state.teachers![index];
                return TeacherCard(teacher: teacher);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class TeacherCard extends StatelessWidget {
  final TeacherModel teacher;

  const TeacherCard({
    super.key,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeacherLevelsScreen(teacher: teacher),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                teacher.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                teacher.email,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (teacher.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  teacher.description!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              const SizedBox(height: 8),
              Text(
                '${teacher.teachingLevels.length} Teaching Levels',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
