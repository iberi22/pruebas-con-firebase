import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';
import '../widgets/user_card.dart';
import '../../domain/entities/user.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
        actions: [
          IconButton(
              onPressed: () {
                _showCreateUserDialog(context, ref, null);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: usersAsync.when(
        data: (users) => ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) => UserCard(
                  user: users[index],
                  onTap: () =>
                      _showCreateUserDialog(context, ref, users[index]),
                )),
        error: (error, stack) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _showCreateUserDialog(BuildContext context, WidgetRef ref, User? user) {
    final nameController = TextEditingController(text: user?.name);
    final emailController = TextEditingController(text: user?.email);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user == null ? 'Crear Usuario' : 'Editar Usuario'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final email = emailController.text.trim();
              if (name.isNotEmpty && email.isNotEmpty) {
                Navigator.pop(context);
                final newUser = User(
                    id: user?.id ?? "",
                    name: name,
                    email: email,
                    avatar: user?.avatar);
                if (user == null) {
                  ref.read(userProvider.notifier).createNewUser(newUser);
                } else {
                  ref.read(userProvider.notifier).updateUserList(newUser);
                }
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
