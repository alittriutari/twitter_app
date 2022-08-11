import 'package:twitter_app/features/domain/repositories/auth_repository.dart';

class IsSignIn {
  final AuthRepository repository;

  IsSignIn({required this.repository});

  Future<bool> call() async {
    return await repository.isSignIn();
  }
}
