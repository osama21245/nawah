import '../../../data/models/teachers_model.dart';

enum HomeStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeState {
  final HomeStatus status;
  final List<TeacherModel>? teachers;
  final String? errorMessage;

  const HomeState({
    required this.status,
    this.teachers,
    this.errorMessage,
  });

  factory HomeState.initial() => const HomeState(
        status: HomeStatus.initial,
      );

  HomeState copyWith({
    HomeStatus? status,
    List<TeacherModel>? teachers,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      teachers: teachers ?? this.teachers,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isInitial => status == HomeStatus.initial;

  bool get isLoading => status == HomeStatus.loading;

  bool get isLoaded => status == HomeStatus.loaded;

  bool get isError => status == HomeStatus.error;
}
