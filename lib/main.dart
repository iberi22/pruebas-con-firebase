import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'config/firebase_options.dart';

class RequerimientosTabla extends StatefulWidget {
  const RequerimientosTabla({super.key});

  @override
  State<RequerimientosTabla> createState() => _RequerimientosTablaState();
}

class _RequerimientosTablaState extends State<RequerimientosTabla> {
  final Stream<QuerySnapshot> _requerimientosStream =
      FirebaseFirestore.instance.collection('requerimientos').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _requerimientosStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Algo salió mal');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Cargando");
        }

        return DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Nombre',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Estado',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Descripción',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return DataRow(
              cells: <DataCell>[
                DataCell(Text(data['nombre'])),
                DataCell(Text(data['estado'])),
                DataCell(Text(data['descripcion'])),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'EMCI - CORE PRUEBAS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CollectionReference requerimientos =
      FirebaseFirestore.instance.collection('requerimientos');

  Future<void> _create() async {
    // Create controllers for the text fields
    final TextEditingController nameController = TextEditingController();
    final TextEditingController statusController = TextEditingController();

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController, // Assign the controller
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: statusController, // Assign the controller
                  decoration: const InputDecoration(labelText: 'Estado'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Crear'),
                  onPressed: () async {
                    // Get the values from the controllers
                    final String name = nameController.text;
                    final String status = statusController.text;
                    final String description = statusController.text;

                    await requerimientos.add({
                      "nombre": name,
                      "descripcion": description,
                      "estado": status
                    });

                    // Hide the bottom sheet
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const RequerimientosTabla(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
