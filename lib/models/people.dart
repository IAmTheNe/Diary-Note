// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PeopleSingleton {
  /// Private constructor to avoid client applications to use constructor
  PeopleSingleton._();

  static PeopleSingleton? _instance;

  /// Returns the instance if it's not null, otherwise it creates it.
  static PeopleSingleton get instance => _instance ??= PeopleSingleton._();

  People? _user;
  People? get user => _user;

  /// If the user is logged in, then we create a new People object with the user's information. If the
  /// user is not logged in, then we create a new People object with anonymous information
  ///
  /// Args:
  ///   people (People): The user object that contains the user's information.
  Future<void> authUser(User? people) async {
    if (people == null) {
      _user = People.anonymous();
    } else {
      _user = People(
        uid: people.uid,
        displayName: people.displayName!,
        email: people.email!,
        photoURL: people.photoURL!,
      );
    }
  }

  /// It takes a UserCredential object as an argument, and then it uses the FirebaseFirestore instance
  /// to create a new document in the users collection, and then it sets the document's fields to the
  /// values of the UserCredential object's user property
  ///
  /// Args:
  ///   credential (UserCredential): The credential object that was passed to the signInWithCredential
  /// method.
  void storeData(UserCredential credential) {
    final db = FirebaseFirestore.instance;
    db.collection("users").doc(credential.user!.uid).set(
      {
        'displayName': credential.user!.displayName,
        'email': credential.user!.email,
        'photoUrl': credential.user!.photoURL,
      },
    );
  }
}

class People {
  final String uid;
  final String displayName;
  final String email;
  final String? photoURL;

  People({
    required this.uid,
    required this.displayName,
    required this.email,
    this.photoURL,
  });

  factory People.anonymous() {
    return People(
      uid: '',
      displayName: '',
      email: '',
    );
  }
}
