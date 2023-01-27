// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Note {
  final String id;
  final String? title;
  final DateTime createdAt;
  final String content;
  final String? image;

  const Note({
    required this.id,
    this.title,
    required this.createdAt,
    required this.content,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'content': content,
      'image': image,
    };
  }

  /// It takes the properties of the class and returns a map of the properties
  ///
  /// Returns:
  ///   A map of the data that is being stored in the database.
  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      if (title != null) "title": title,
      "createdAt": createdAt,
      "content": content,
      if (image != null) "image": image,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] != null ? map['title'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      content: map['content'] as String,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  factory Note.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Note(
      id: data?['id'],
      title: data?['title'] ?? '',
      createdAt: data?['createdAt'],
      content: data?['content'],
      image: data?['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum NoteCategory {
  reminder(icon: CupertinoIcons.bell, color: Colors.green),
  todo(icon: CupertinoIcons.checkmark, color: Colors.yellow),
  audio(icon: CupertinoIcons.music_albums, color: Colors.yellow),
  image(icon: CupertinoIcons.photo, color: Colors.yellow);

  final IconData icon;
  final Color color;

  const NoteCategory({
    required this.icon,
    required this.color,
  });
}
