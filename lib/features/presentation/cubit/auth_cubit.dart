import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twitter_app/features/domain/usecases/do_logout.dart';
import 'package:twitter_app/features/domain/usecases/get_current_uid.dart';
import 'package:twitter_app/features/domain/usecases/is_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignIn isSignIn;
  final GetCurrentUid getCurrentUid;
  final DoLogout doLogout;
  AuthCubit(
      {required this.isSignIn,
      required this.getCurrentUid,
      required this.doLogout})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isLoggedIn = await isSignIn();
      if (isLoggedIn) {
        final uid = await getCurrentUid();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(UnAuthenticated());
    }
  }

  Future<void> logout() async {
    try {
      await doLogout();
      emit(UnAuthenticated());
    } catch (e) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUid();
      emit(Authenticated(uid: uid));
    } catch (e) {
      emit(UnAuthenticated());
    }
  }
}
