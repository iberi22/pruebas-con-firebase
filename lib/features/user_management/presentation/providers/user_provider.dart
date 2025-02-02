import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/usecases/usecase.dart';
import '../../data/datasources/user_remote_datasource_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/get_users.dart';
import '../../domain/usecases/update_user.dart';
import '../../domain/usecases/delete_user.dart'; // <-- Añadimos la importación de DeleteUser
import '../../../../core/services/firebase_service.dart';

class UserNotifier extends StateNotifier<AsyncValue<List<User>>> {
  final GetUsers getUsers;
  final CreateUser createUser;
  final UpdateUser updateUser;
  final DeleteUser deleteUser; // <-- Añadimos DeleteUser al notifier
  UserNotifier(
      {required this.getUsers,
      required this.createUser,
      required this.updateUser,
      required this.deleteUser})
      : super(const AsyncValue.loading()) {
    loadUsers();
  }

  Future<void> loadUsers() async {
    state = const AsyncValue.loading();
    final result = await getUsers(); // <-- ¡Elimina NoParams() de aquí!
    state = result.when(
        success: (data) => AsyncValue.data(data),
        error: (failure) => AsyncValue.error(
            failure.message ?? "Ha ocurrido un error", StackTrace.current));
  }

  Future<void> createNewUser(User user) async {
    state = const AsyncValue.loading();
    final result = await createUser(CreateUserParams(user: user));
    state = result.when(
        success: (data) {
          loadUsers();
          return AsyncValue.data(state.value ?? []);
        },
        error: (failure) => AsyncValue.error(
            failure.message ?? "Ha ocurrido un error", StackTrace.current));
  }

  Future<void> updateUserList(User user) async {
    state = const AsyncValue.loading();
    final result = await updateUser(UpdateUserParams(user: user));
    state = result.when(
        success: (data) {
          loadUsers();
          return AsyncValue.data(state.value ?? []);
        },
        error: (failure) => AsyncValue.error(
            failure.message ?? "Ha ocurrido un error", StackTrace.current));
  }

  Future<void> deleteUserList(String userId) async {
    state = const AsyncValue.loading();
    final result = await deleteUser(DeleteUserParams(id: userId));
    state = result.when(
        success: (data) {
          loadUsers();
          return AsyncValue.data(state.value ?? []);
        },
        error: (failure) => AsyncValue.error(
            failure.message ?? "Ha ocurrido un error", StackTrace.current));
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<List<User>>>((ref) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  final userRemoteDataSource =
      UserRemoteDataSourceImpl(firebaseService: firebaseService);
  final userRepository =
      UserRepositoryImpl(remoteDataSource: userRemoteDataSource);
  final getUsers = GetUsers(repository: userRepository);
  final createUser = CreateUser(repository: userRepository);
  final updateUser = UpdateUser(repository: userRepository);
  final deleteUser = DeleteUser(
      repository:
          userRepository); // <-- Añadimos DeleteUser a la creación del provider
  return UserNotifier(
      getUsers: getUsers,
      createUser: createUser,
      updateUser: updateUser,
      deleteUser:
          deleteUser); // <-- Añadimos DeleteUser al constructor del Notifier
});
