import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    required UserStatus status,
    required List<User> users,
    String? errorMessage,
  }) = _UserState;

  factory UserState.initial() => const UserState(
        status: UserStatus.initial,
        users: [],
      );
}

enum UserStatus { initial, loading, loaded, error }
