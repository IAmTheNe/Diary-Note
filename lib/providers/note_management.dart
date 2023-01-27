import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteManagement with ChangeNotifier {
  List<Note> _notes = [];

  /// It returns a copy of the list note.
  List<Note> get notes => [..._notes];

  final _db = FirebaseFirestore.instance;

  // Future<void> createNote(Note note) async {
  //   final uid = PeopleSingleton.instance.user!.uid;
  //   final docRef = _db
  //       .collection("notes")
  //       .withConverter(
  //         fromFirestore: Note.fromFirestore,
  //         toFirestore: (Note note, _) => note.toFirestore(),
  //       )
  //       .doc(uid);
  //   note.id = uid;
  //   await docRef.set(note);
  //   _notes.add(note);
  //   notifyListeners();
  // }
}
