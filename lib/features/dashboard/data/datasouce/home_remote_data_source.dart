import '../../../../core/constants/api_links.dart';
import '../../../../core/utils/crud.dart';
import '../../../../core/utils/try_and_catch.dart';
import '../models/teachers_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<Map<String, dynamic>>> getTeachers();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Crud crud;

  HomeRemoteDataSourceImpl(this.crud);

  @override
  Future<List<Map<String, dynamic>>> getTeachers() async {
    return executeTryAndCatchForDataLayer(() async {
      final response = await crud.getData(ApiLinks.getTeachers, {});

      final teachersList = (response['teachers'] as List)
          .map((teacher) => teacher as Map<String, dynamic>)
          .toList();

      return teachersList;
    });
  }
}
