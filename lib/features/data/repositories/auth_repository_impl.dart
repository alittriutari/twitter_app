import 'package:twitter_app/features/data/datasource/auth_remote_data_source.dart';
import 'package:twitter_app/features/domain/entities/user.dart';
import 'package:twitter_app/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});
  @override
  Future<void> signIn(Users user) async => dataSource.signIn(user);

  @override
  Future<void> signUp(Users user) async => dataSource.signUp(user);

  @override
  Future<void> signOut() async => dataSource.logout();

  @override
  Future<bool> isSignIn() async => dataSource.isSignIn();

  @override
  Future<String> getCurrentUid() async => dataSource.getCurrentUId();
}
