import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_state.dart';

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
                backgroundImage: NetworkImage(user.user!.photoUrl ?? ''),
              ),
              const SizedBox(
                height: 16,
              ),
              Text('Display Name: ${user.user!.displayName}'),
              const SizedBox(
                height: 4,
              ),
              Text('Email: ${user.user!.email}'),
            ],
          ),
        ),
      ),
    );
  }
}
