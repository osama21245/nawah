// import 'package:fpdart/fpdart.dart';
//
// import '../../../../core/erorr/failure.dart';
// import '../../../../core/utils/try_and_catch.dart';
// import '../datasouce/home_remote_data_source.dart';
// import '../models/teachers_model.dart';
//
// class HomeRepository {
//   final HomeRemoteDataSource remoteDataSource;
//
//   HomeRepository({required this.remoteDataSource});
//
//   Future<Either<Failure, List<TeacherModel>>> getTeachers() async {
//     return executeTryAndCatchForRepository(() async {
//       final teachers = await remoteDataSource.getTeachers();
//       return teachers.map((teacher) => TeacherModel.fromMap(teacher)).toList();
//     });
//   }
// }
