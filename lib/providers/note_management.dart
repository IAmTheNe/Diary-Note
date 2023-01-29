import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteManagement with ChangeNotifier {
  List<Note> _notes = [];

  /// It returns a copy of the list note.
  List<Note> get notes => [..._notes];

  final _db = FirebaseFirestore.instance;

  Future<void> createNote(Note note) async {
    final docRef = _db.collection("notes").doc().withConverter(
          fromFirestore: Note.fromFirestore,
          toFirestore: (Note note, _) => note.toFirestore(),
        );
    await docRef.set(note);
    _notes.add(note);
    notifyListeners();
  }

  Future<void> fetchAllNotes(String uid) async {
    final docRef = _db
        .collection("notes")
        .withConverter(
          fromFirestore: Note.fromFirestore,
          toFirestore: (Note note, _) => note.toFirestore(),
        )
        .where("userId", isEqualTo: uid);

    final docSnap = await docRef.get();
    final List<Note> loadData = [];
    for (var e in docSnap.docs) {
      loadData.add(e.data());
    }
    loadData.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _notes = loadData;
    notifyListeners();
    // print(docSnap.docs);
  }
}
