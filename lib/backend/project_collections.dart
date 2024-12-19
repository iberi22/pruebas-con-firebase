import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectCollectionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createProjectCollection(String projectId, Map<String, dynamic> data) async {
    try {
      await _db.collection('proyectos').doc(projectId).set(data);
      print('Project collection created successfully');
    } catch (e) {
      print('Error creating project collection: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProjectsCollection() {
    return _db.collection('proyectos').snapshots();
  }
}