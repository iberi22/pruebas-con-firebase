import 'package:cloud_firestore/cloud_firestore.dart';

class RequirementCollectionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createRequirementCollection(
      Map<String, dynamic> data, String requirementId) async {
    try {
      await _firestore.collection('requirements').doc(requirementId).set(data);
    } catch (e) {
      // Handle errors appropriately, e.g., log the error or throw a custom exception
      print("Error creating requirement collection: $e");
    }
  }

  Stream<QuerySnapshot> getRequirementsCollection() {
    return _firestore.collection('requirements').snapshots();
  }
}
