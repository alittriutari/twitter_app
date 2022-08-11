import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_app/features/domain/entities/user.dart';
import 'package:twitter_app/features/domain/usecases/do_sign_in.dart';
import 'package:twitter_app/features/domain/usecases/do_sign_up.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final DoSignUp doSignUp;
  final DoSignIn doSignIn;
  UsersCubit({required this.doSignUp, required this.doSignIn})
      : super(UsersInitial());

  Future<void> signUp(Users users) async {
    emit(UserLoading());
    try {
      await doSignUp(users);
      emit(UsersLoaded());
    } catch (e) {
      emit(UserFailure());
    }
  }

  Future<void> signIn(Users users) async {
    emit(UserLoading());
    try {
      await doSignIn(users);

      emit(UsersLoaded());
    } catch (e) {
      emit(UserFailure());
    }
  }
}
