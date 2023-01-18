// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] != null ? map['title'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      content: map['content'] as String,
      image: map['image'] != null ? map['image'] as String : null,
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
