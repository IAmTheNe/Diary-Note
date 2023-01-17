import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class ApplicationState with ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _isLogin = false;

  /// Return a state of your app.
  bool get login => _isLogin;

  /// It initializes the Firebase app and listens for changes in the user's authentication state
  Future<void> init() async {
    /// It initializes the Firebase app.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    /// Listening for changes in the user's authentication state.
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        _isLogin = false;
      } else {
        _isLogin = true;
      }
    });

    /// Notifying the listeners that the state has changed.
    notifyListeners();
  }
}
