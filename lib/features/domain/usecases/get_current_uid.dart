import 'package:twitter_app/features/domain/repositories/auth_repository.dart';

class GetCurrentUid {
  final AuthRepository repository;

  GetCurrentUid({required this.repository});

  Future<String> call() async {
    return await repository.getCurrentUid();
  }
}
