import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectCollectionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createProjectCollection(Map<String, dynamic> data) async {
    try {
      await _db.collection('proyectos').add(data);
      print('Coleccion de proyecto creado exitosamente');
    } catch (e) {   
      print('Error al crear el coleccion de proyecto: $e');
    }
  }

  // ... otros métodos
}