import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    this.padding,
    required this.title,
    this.createdAt,
    this.content,
    this.image,
    this.todo,
    this.audio,
    this.type = NoteCategory.reminder,
  });

  final EdgeInsetsGeometry? padding;
  final Widget title;
  final Widget? createdAt;
  final Widget? content;
  final String? image;
  final Widget? todo;
  final Widget? audio;
  final NoteCategory? type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          padding: padding ?? const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: title,
                subtitle: createdAt,
                leading: noteType(),
              ),
              const Divider(
                indent: 8,
                endIndent: 8,
                thickness: 2.0,
              ),
              if (image != null)
                Container(
                  padding: padding ?? const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(image!),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (content != null)
                ListTile(
                  title: content,
                ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? noteType() {
    return CircleAvatar(
      backgroundColor: type!.color.withOpacity(.8),
      child: Icon(
        type!.icon,
        color: Colors.white,
      ),
    );
  }
}
