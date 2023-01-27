import 'package:flutter/material.dart';
import 'package:note_app/providers/app_state.dart';
import 'package:note_app/utils/date_time_formatter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Consumer<ApplicationState>(
          builder: (context, user, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundImage: NetworkImage(user.user!.photoURL!),
              ),
              const SizedBox(
                height: 16,
              ),
              Text('Display Name: ${user.user!.displayName}'),
              const SizedBox(
                height: 4,
              ),
              Text('Email: ${user.user!.email}'),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Date Join: ${DateTimeFormatter.customPattern(
                  pattern: 'dd/MM/yyyy',
                  time: user.user!.creationTime,
                )}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
