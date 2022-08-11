import 'package:twitter_app/features/domain/repositories/auth_repository.dart';

class DoLogout {
  final AuthRepository repository;

  DoLogout({required this.repository});

  Future<void> call() async {
    return await repository.signOut();
  }
}
