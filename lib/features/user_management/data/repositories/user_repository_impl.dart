import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<User>> createUser(User user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final result = await remoteDataSource.createUser(userModel);
      return Success(result.toEntity());
    } on ServerException catch (e) {
      return Error(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Error(UnknownFailure());
    }
  }

  @override
  Future<Result<void>> deleteUser(String id) async {
    try {
      await remoteDataSource.deleteUser(id);
      return const Success(null);
    } on ServerException catch (e) {
      return Error(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Error(UnknownFailure());
    }
  }

  @override
  Future<Result<List<User>>> getUsers() async {
    try {
      final result = await remoteDataSource.getUsers();
      return Success(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Error(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Error(UnknownFailure());
    }
  }

  @override
  Future<Result<User>> getUser(String id) async {
    try {
      final result = await remoteDataSource.getUser(id);
      return Success(result.toEntity());
    } on ServerException catch (e) {
      return Error(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Error(UnknownFailure());
    }
  }

  @override
  Future<Result<User>> updateUser(User user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final result = await remoteDataSource.updateUser(userModel);
      return Success(result.toEntity());
    } on ServerException catch (e) {
      return Error(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Error(UnknownFailure());
    }
  }
}

class ServerException implements Exception {
  final String? message;
  final int? statusCode;
  ServerException({this.message, this.statusCode});
}
