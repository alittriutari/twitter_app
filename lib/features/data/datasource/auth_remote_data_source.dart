import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_app/features/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<void> signIn(Users users);
  Future<void> signUp(Users users);
  Future<void> logout();
  Future<bool> isSignIn();
  Future<String> getCurrentUId();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({required this.firebaseAuth});
  @override
  Future<void> signIn(Users users) async =>
      firebaseAuth.signInWithEmailAndPassword(
          email: users.email!, password: users.password!);

  @override
  Future<void> signUp(Users users) async =>
      firebaseAuth.createUserWithEmailAndPassword(
          email: users.email!, password: users.password!);

  @override
  Future<void> logout() async => firebaseAuth.signOut();

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<String> getCurrentUId() async => firebaseAuth.currentUser!.uid;
}
