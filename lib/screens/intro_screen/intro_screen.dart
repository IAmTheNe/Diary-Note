import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../providers/app_state.dart';
import '../../widgets/styled_button.dart';

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
                  .copyWith(color: Colors.white, height: 1.5),
            ),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Consumer<ApplicationState>(
              builder: (context, google, child) => StyledButton(
                label: child!,
                icon: const FaIcon(FontAwesomeIcons.google),
                onPressed: () {
                  google.signInWithGoogleMethod();
                },
              ),
              child: const Text(
                'Login with Google',
                style: TextStyle(letterSpacing: .6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
