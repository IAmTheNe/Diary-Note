import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Note {
  late final String id;
  late final String title;
  late final DateTime createdAt;
  late final String? content;
  late final String? image;
  late final NoteCategory? type;
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
