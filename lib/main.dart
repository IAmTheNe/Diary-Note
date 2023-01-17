import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './screens/create_screen/create_note_screen.dart';
import './screens/home_screen/home_screen.dart';
import './screens/intro_screen/intro_screen.dart';
import './utils/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  /// A method that is called to ensure that the binding has been initialized.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note me',
      debugShowCheckedModeBanner: false,
      darkTheme: AppStyle.dark,
      themeMode: ThemeMode.dark,
      // home: const IntroductionScreen(),
      initialRoute: IntroductionScreen.routeName,
      routes: {
        '/': (context) => const HomeScreen(),
        IntroductionScreen.routeName: (context) => const IntroductionScreen(),
        CreateNewNoteScreen.routeName: (context) => const CreateNewNoteScreen(),
      },
    );
  }
}
