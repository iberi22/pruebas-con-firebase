import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:myapp/backend/project_collections.dart';
import 'package:myapp/backend/requirement_collections.dart';
import 'package:myapp/backend/user_collections.dart';

Future<void> initializeData() async {
  // Inicializa los servicios
  final projectService = ProjectCollectionService();
  final requirementService = RequirementCollectionService();
  final userService = UserCollectionService();

  // Crea usuarios de prueba
  await userService
      .createUser({'nombre': 'Usuario 1', 'email': 'usuario1@example.com'});
  // ... otros usuarios

  // Crea proyectos de prueba
  await projectService.createProject({
    'nombre': 'Proyecto A',
    'numero': 'PRD-2024-002',
    'fecha': FieldValue.serverTimestamp(),
    'version': '01',
    'estado': 'En elaboración',
    'autor': 'Usuario 1', // Puedes usar la referencia a un usuario creado
    'descripcion': 'Descripción del proyecto A',
    'objetivos': 'Objetivos del proyecto A'
  });

  // ... otros proyectos

  // Crea requerimientos de prueba (asociados a proyectos existentes)
  await requirementService.createRequirement({
    'nombre': 'Plan de Trabajo',
    'tipo': 'Documento',
    'descripcion':
        'Define las actividades, responsables y plazos para el proyecto.',
    'padre': null,
    'estado': 'Pendiente',
    'proyectoId':
        'proyectoA' // Asegúrate que coincide con un proyecto existente
  });

  // ... otros requerimientos

  print('Datos iniciales cargados.');
}
