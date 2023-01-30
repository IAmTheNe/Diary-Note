import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteManagement with ChangeNotifier {
  List<Note> _notes = [];

  /// It returns a copy of the list note.
  List<Note> get notes => [..._notes];

  final _db = FirebaseFirestore.instance;

  /// It adds the note to the list of notes
  ///
  /// Args:
  ///   note (Note): The note that we want to add to the database.
  Future<void> createNote(Map<String, dynamic> map) async {
    final docRef = _db.collection("notes").doc().withConverter(
          fromFirestore: Note.fromFirestore,
          toFirestore: (Note note, _) => note.toFirestore(),
        );
    map['noteId'] = docRef.id;
    final note = Note.fromMap(map);
    await docRef.set(note);
    _notes.add(note);
    notifyListeners();
  }

  /// It fetches all the notes from the database, converts them to a list of Note objects, sorts them by
  /// date
  ///
  /// Args:
  ///   uid (String): The user id of the user who is logged in.
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

  /// It deletes a note from the database and from the local list of notes
  ///
  /// Args:
  ///   note (Note): The note object that we want to delete.
  Future<void> deleteNote(Note note) async {
    final docRef = _db.collection("notes").doc(note.noteId);
    final existNote = _notes.indexWhere((n) => n.noteId == note.noteId);
    _notes.removeAt(existNote);
    notifyListeners();

    await docRef.delete();
  }

  /// It takes a note object, gets the document reference of the note, updates the note, and then
  /// updates the local list of notes
  ///
  /// Args:
  ///   note (Note): The note object that you want to update.
  Future<void> updateNote(Note note) async {
    final docRef = _db.collection("notes").doc(note.noteId).withConverter(
          fromFirestore: Note.fromFirestore,
          toFirestore: (Note note, _) => note.toFirestore(),
        );

    await docRef.update(note.toMap());
    final existNote = _notes.indexWhere((n) => n.noteId == note.noteId);
    _notes[existNote] = note;
    notifyListeners();
  }
}
