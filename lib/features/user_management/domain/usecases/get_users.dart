import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsers implements UseCaseWithoutParams<List<User>> {
  final UserRepository repository;
  GetUsers({required this.repository});

  @override
  Future<Result<List<User>>> call() {
    return repository.getUsers();
  }
}
