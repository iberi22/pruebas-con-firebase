import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Result<User>> createUser(User user);
  Future<Result<List<User>>> getUsers();
  Future<Result<User>> updateUser(User user);
  Future<Result<User>> getUser(String id);
  Future<Result<void>> deleteUser(String id);
}
