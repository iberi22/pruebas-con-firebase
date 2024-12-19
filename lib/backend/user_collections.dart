import 'package:cloud_firestore/cloud_firestore.dart';

class UserCollectionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(Map<String, dynamic> userData) async {
    try {
      await _db.collection('users').add(userData);
      print('User created successfully');
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      final doc = await _db.collection('users').doc(userId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        print('User not found');
        return null;
      }
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> updatedData) async {
    try {
      await _db.collection('users').doc(userId).update(updatedData);
      print('User updated successfully');
    } catch (e) {
      print('Error updating user: $e');
    }
  }
}