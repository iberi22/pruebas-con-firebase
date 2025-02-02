import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/services/firebase_service.dart';
import '../models/user_model.dart';
import 'user_remote_datasource.dart';
import '../repositories/user_repository_impl.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseService firebaseService;
  final String collectionName = 'users';

  UserRemoteDataSourceImpl({required this.firebaseService});

  @override
  Future<UserModel> createUser(UserModel user) async {
    try {
      final userDoc =
          firebaseService.firestore.collection(collectionName).doc();
      final newUser = user.copyWith(id: userDoc.id);
      await userDoc.set(newUser.toJson());
      final result = await userDoc.get();
      return UserModel.fromJson(result.data()!);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message, statusCode: e.code.hashCode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      await firebaseService.firestore
          .collection(collectionName)
          .doc(id)
          .delete();
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message, statusCode: e.code.hashCode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final querySnapshot =
          await firebaseService.firestore.collection(collectionName).get();
      return querySnapshot.docs
          .map((e) => UserModel.fromJson(e.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message, statusCode: e.code.hashCode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getUser(String id) async {
    try {
      final result = await firebaseService.firestore
          .collection(collectionName)
          .doc(id)
          .get();
      return UserModel.fromJson(result.data()!);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message, statusCode: e.code.hashCode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    try {
      await firebaseService.firestore
          .collection(collectionName)
          .doc(user.id)
          .update(user.toJson());
      final result = await firebaseService.firestore
          .collection(collectionName)
          .doc(user.id)
          .get();
      return UserModel.fromJson(result.data()!);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message, statusCode: e.code.hashCode);
    } catch (e) {
      rethrow;
    }
  }
}
