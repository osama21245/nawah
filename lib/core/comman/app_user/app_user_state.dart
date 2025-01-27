part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserIsLogIn extends AppUserState {
  final UserModel user;

  AppUserIsLogIn({required this.user});
}
