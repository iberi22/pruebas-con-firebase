import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UpdateUser implements UseCase<User, UpdateUserParams> {
  final UserRepository repository;

  UpdateUser({required this.repository});

  @override
  Future<Result<User>> call(UpdateUserParams params) {
    return repository.updateUser(params.user);
  }
}

class UpdateUserParams {
  final User user;
  UpdateUserParams({required this.user});
}
