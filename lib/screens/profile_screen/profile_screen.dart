import 'package:flutter/material.dart';
import 'package:note_app/models/people.dart';
import 'package:note_app/utils/date_time_formatter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final user = PeopleSingleton.instance.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundImage: NetworkImage(user!.photoURL!),
            ),
            const SizedBox(
              height: 16,
            ),
            Text('Display Name: ${user.displayName}'),
            const SizedBox(
              height: 4,
            ),
            Text('Email: ${user.email}'),
            const SizedBox(
              height: 4,
            ),
            Text("Date Join: ${DateTimeFormatter.customPattern(
              pattern: 'dd/MM/yyyy',
              time: user.creationTime,
            )}"),
          ],
        ),
      ),
    );
  }
}
