// lib/core/errors/failures.dart
import 'package:flutter/foundation.dart';

@immutable
sealed class Failure {
  final String? message;
  const Failure({this.message}); // <-- ¡VOLVEMOS A PONER 'const' AQUÍ!
}

final class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({super.message, this.statusCode});
}

final class CacheFailure extends Failure {
  const CacheFailure({super.message});
}

final class AuthFailure extends Failure {
  const AuthFailure({super.message});
}

final class InvalidDataFailure extends Failure {
  const InvalidDataFailure({super.message});
}

final class UnknownFailure extends Failure {
  const UnknownFailure({super.message});
}
