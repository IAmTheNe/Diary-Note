import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/people.dart';

class ApplicationState with ChangeNotifier {
  ApplicationState() {
    _init();
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  People? _user;

  People? get user => _user;

  /// Returns the user.
  /// Return a state of your app.

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

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    PeopleSingleton.instance.storeData(userCredential);

    notifyListeners();
  }

  /// It signs out the user from the app and from Google
  Future<void> signOut() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  /// It initializes the Firebase app and listens for changes in the user's authentication state
  void _init() {
    /// Listening for changes in the user's authentication state.
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        _user = null;
      } else {
        _user = People(
          uid: user.uid,
          displayName: user.displayName!,
          email: user.email!,
          photoURL: user.photoURL,
          creationTime: user.metadata.creationTime,
        );
      }
      notifyListeners();
    });
  }
}
