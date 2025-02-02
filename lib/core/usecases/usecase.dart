import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type>> call(Params params);
}

// Defina un tipo genérico para el resultado
sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

final class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);
}

// Un caso de uso sin parámetros
abstract class UseCaseWithoutParams<Type> {
  Future<Result<Type>> call();
}
