import 'package:flutter/foundation.dart';

@immutable
sealed class Failure {
  const Failure();
}

final class ServerFailure extends Failure {
  final String? message;
  final int? statusCode;
  const ServerFailure({this.message, this.statusCode});
}

final class CacheFailure extends Failure {
  final String? message;
  const CacheFailure({this.message});
}

final class AuthFailure extends Failure {
  final String? message;
  const AuthFailure({this.message});
}

final class InvalidDataFailure extends Failure {
  final String? message;
  const InvalidDataFailure({this.message});
}

final class UnknownFailure extends Failure {
  final String? message;
  const UnknownFailure({this.message});
}
