import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onTap;
  const UserCard({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(user.name.substring(0, 1).toUpperCase()),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: onTap,
        ),
      ),
    );
  }
}
