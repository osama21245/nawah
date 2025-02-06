import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeCubit(this._repository) : super(HomeState.initial());

  Future<void> getTeachers() async {
    emit(state.copyWith(status: HomeStatus.loading));

    final result = await _repository.getTeachers();
    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: failure.message,
      )),
      (teachers) => emit(state.copyWith(
        status: HomeStatus.loaded,
        teachers: teachers,
      )),
    );
  }
}
