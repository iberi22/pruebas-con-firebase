import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/services/firebase_service.dart';
import 'features/user_management/presentation/pages/user_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseService = await FirebaseService.initialize();
  runApp(ProviderScope(
    overrides: [firebaseServiceProvider.overrideWithValue(firebaseService)],
    child: const MyApp(),
  ));
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
      home: const UserListPage(),
    );
  }
}
