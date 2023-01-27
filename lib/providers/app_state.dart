import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app/models/people.dart';

class ApplicationState with ChangeNotifier {
  ApplicationState() {
    _init();
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

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

    /// Signing in the user with the credential.
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
  Future<void> _init() async {
    /// Listening for changes in the user's authentication state.
    FirebaseAuth.instance.authStateChanges().listen((user) {
      PeopleSingleton.instance.authUser(user);
      notifyListeners();
    });
  }
}
