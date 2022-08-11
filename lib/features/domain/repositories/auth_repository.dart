import 'package:twitter_app/features/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> signIn(Users user);
  Future<void> signUp(Users user);
  Future<void> signOut();
  Future<bool> isSignIn();
  Future<String> getCurrentUid();
}
