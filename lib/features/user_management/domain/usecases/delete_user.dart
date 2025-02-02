import '../../../../core/usecases/usecase.dart';
import '../repositories/user_repository.dart';

class DeleteUser implements UseCase<void, DeleteUserParams> {
  final UserRepository repository;

  DeleteUser({required this.repository});

  @override
  Future<Result<void>> call(DeleteUserParams params) {
    return repository.deleteUser(params.id);
  }
}

class DeleteUserParams {
  final String id;
  DeleteUserParams({required this.id});
}
