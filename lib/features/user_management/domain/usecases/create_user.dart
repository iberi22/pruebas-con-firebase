import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class CreateUser implements UseCase<User, CreateUserParams> {
  final UserRepository repository;

  CreateUser({required this.repository});

  @override
  Future<Result<User>> call(CreateUserParams params) async {
    return await repository.createUser(params.user);
  }
}

class CreateUserParams {
  final User user;
  CreateUserParams({required this.user});
}
