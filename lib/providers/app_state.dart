import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';

class ApplicationState with ChangeNotifier {
  ApplicationState() {
    _init();
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _db = FirebaseFirestore.instance;

  bool _isLogin = false;

  AppUser? _user;

  AppUser? get user => _user;

  /// Returns the user.

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

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final userCredentialInfo = userCredential.user;

    _db.collection('user').doc(userCredentialInfo!.uid).set(
      <String, dynamic>{
        'displayName': userCredentialInfo.displayName,
        'email': userCredentialInfo.email,
        'photoUrl': userCredentialInfo.photoURL,
      },
    );
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
      if (user == null) {
        _isLogin = false;
        _user = null;
      } else {
        _isLogin = true;
        _user = AppUser(
          uid: user.uid,
          displayName: user.displayName!,
          email: user.email!,
          photoURL: user.photoURL,
        );
        print(user.photoURL);
      }
      notifyListeners();
    });
  }
}
