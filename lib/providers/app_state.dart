import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ApplicationState with ChangeNotifier {
  ApplicationState() {
    _init();
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  bool _isLogin = false;

  /// Returns the user.
  GoogleSignInAccount? get user => _user;

  /// Return a state of your app.
  bool get isLogin => _isLogin;

  /// It signs in the user with Google, and if the user is not null, it sets the user to the google
  /// user, and then it gets the authentication of the google user, and then it creates a credential
  /// with the access token and id token of the google user, and then it signs in the user with the
  /// credential, and then it notifies the listeners
  ///
  /// Returns:
  ///   The user is being returned.
  Future<void> signInWithGoogleMethod() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }

  /// It signs out the user from the app and from Google
  Future<void> signOut() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }

  /// It initializes the Firebase app and listens for changes in the user's authentication state
  Future<void> _init() async {
    /// Listening for changes in the user's authentication state.
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        _isLogin = false;
      } else {
        _isLogin = true;
      }
      notifyListeners();
    });
  }
}
