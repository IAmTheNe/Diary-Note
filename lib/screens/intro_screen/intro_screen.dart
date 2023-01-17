import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});
  static const routeName = '/intro';

  @override
  Widget build(BuildContext context) {
    /// Getting the height of the screen.
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.5,
            child: Lottie.asset(
              'assets/animations/notes.json',
              repeat: true,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            'Diary Notes',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Take notes, reminders, set targets, collect resources and secure privacy',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: const Text(
              'Login with Google',
              style: TextStyle(
                letterSpacing: .6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
