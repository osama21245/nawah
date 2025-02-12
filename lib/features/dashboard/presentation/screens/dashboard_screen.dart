import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/teachers_model.dart';
import '../cubits/home/home_cubit.dart';
import '../cubits/home/home_state.dart';
import '../widgets/dashboardScreen/custom__build_mentorGrid.dart';
import '../widgets/dashboardScreen/custom_build_course_list.dart';
import '../widgets/dashboardScreen/custom_build_section_title.dart';
import 'teacher_levels_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello Ebrahim 👋",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Happy studying!",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 24),
              CustomBuildSectionTitle(context, "My Courses",
                  action: "View All"),
              const SizedBox(height: 12),
              const CustomBuildCourseList(),
              const SizedBox(height: 24),
              CustomBuildSectionTitle(
                context,
                "Courses by Mentors",
              ),
              const SizedBox(height: 12),
              const Expanded(child: CustomBuildMentorGrid()),
            ],
          ),
        ),
      ),

      // BlocBuilder<HomeCubit, HomeState>(
      //   builder: (context, state) {
      //     if (state.isLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //
      //     if (state.isError) {
      //       return Center(child: Text('Error: ${state.errorMessage}'));
      //     }
      //
      //     if (state.isLoaded && state.teachers != null) {
      //       return ListView.builder(
      //         padding: const EdgeInsets.all(16),
      //         itemCount: state.teachers!.length,
      //         itemBuilder: (context, index) {
      //           final teacher = state.teachers![index];
      //           return TeacherCard(teacher: teacher);
      //         },
      //       );
      //     }
      //
      //     return const SizedBox();
      //   },
      // ),
    );
  }
}

// class TeacherCard extends StatelessWidget {
//   final TeacherModel teacher;
//
//   const TeacherCard({
//     super.key,
//     required this.teacher,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => TeacherLevelsScreen(teacher: teacher),
//             ),
//           );
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 teacher.name,
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 teacher.email,
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               if (teacher.description != null) ...[
//                 const SizedBox(height: 8),
//                 Text(
//                   teacher.description!,
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//               ],
//               const SizedBox(height: 8),
//               Text(
//                 '${teacher.teachingLevels.length} Teaching Levels',
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
