import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteManagement with ChangeNotifier {
  List<Note> _notes = [];

  /// It returns a copy of the list note.
  List<Note> get notes => [..._notes];

  final _db = FirebaseFirestore.instance;

  /// It returns a Future that will eventually return a List of Note objects
  ///
  /// Returns:
  ///   A Future<List<Note>?>
  // Future<List<Note>?> fetchAllNotes() async {
  //   // _notes.add();
  //   final ref = _db.collection("note").doc("").withConverter(
  //         fromFirestore: Note.fromFirestore,
  //         toFirestore: (Note note, _) => note.toFirestore(),
  //       );
  //   final docSnap = await ref.get();
  //   final note = docSnap.data();
  //   return null;
  // }

  Future<void> createNote() async {}
}
