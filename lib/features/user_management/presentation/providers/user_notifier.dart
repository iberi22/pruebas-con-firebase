import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_users.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/update_user.dart';
import '../../domain/usecases/delete_user.dart';
import 'user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  final GetUsers _getUsers;
  final CreateUser _createUser;
  final UpdateUser _updateUser;
  final DeleteUser _deleteUser;

  UserNotifier({
    required GetUsers getUsers,
    required CreateUser createUser,
    required UpdateUser updateUser,
    required DeleteUser deleteUser,
  })  : _getUsers = getUsers,
        _createUser = createUser,
        _updateUser = updateUser,
        _deleteUser = deleteUser,
        super(UserState.initial());

  Future<void> getUsers() async {
    state = state.copyWith(status: UserStatus.loading);

    final result = await _getUsers();

    state = result.fold(
      (failure) => state.copyWith(
        status: UserStatus.error,
        errorMessage: failure.message,
      ),
      (users) => state.copyWith(
        status: UserStatus.loaded,
        users: users,
      ),
    );
  }

  Future<void> createUser(User user) async {
    state = state.copyWith(status: UserStatus.loading);

    final result = await _createUser(CreateUserParams(user));

    state = result.fold(
      (failure) => state.copyWith(
        status: UserStatus.error,
        errorMessage: failure.message,
      ),
      (createdUser) => state.copyWith(
        status: UserStatus.loaded,
        users: [...state.users, createdUser],
      ),
    );
  }

  Future<void> updateUser(User user) async {
    state = state.copyWith(status: UserStatus.loading);

    final result = await _updateUser(UpdateUserParams(user));

    state = result.fold(
      (failure) => state.copyWith(
        status: UserStatus.error,
        errorMessage: failure.message,
      ),
      (updatedUser) {
        final updatedUsers = state.users
            .map((u) => u.id == updatedUser.id ? updatedUser : u)
            .toList();

        return state.copyWith(
          status: UserStatus.loaded,
          users: updatedUsers,
        );
      },
    );
  }

  Future<void> deleteUser(String userId) async {
    state = state.copyWith(status: UserStatus.loading);

    final result = await _deleteUser(DeleteUserParams(userId));

    state = result.fold(
      (failure) => state.copyWith(
        status: UserStatus.error,
        errorMessage: failure.message,
      ),
      (_) => state.copyWith(
        status: UserStatus.loaded,
        users: state.users.where((user) => user.id != userId).toList(),
      ),
    );
  }
}
