import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:note_app/providers/app_state.dart';
import 'package:note_app/utils/date_time_formatter.dart';
import 'package:provider/provider.dart';

import '../../models/note.dart';
import '../../providers/note_management.dart';
import '../../utils/theme.dart';
import '../../widgets/note_card.dart';
import '../create_screen/create_note_screen.dart';

class AllNotesTab extends StatelessWidget {
  const AllNotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: Consumer2<NoteManagement, ApplicationState>(
          builder: (context, note, app, child) => FutureBuilder(
            future: note.fetchAllNotes(app.user!.uid),
            builder: (context, snapshot) => ListView.builder(
              itemBuilder: (context, index) =>
                  AnimationConfiguration.staggeredGrid(
                position: 1,
                columnCount: 1,
                duration: const Duration(milliseconds: 500),
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    curve: Curves.easeInCubic,
                    child: NoteCard(
                      title: Text(
                        note.notes[index].title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      type: NoteCategory.reminder,
                      createdAt: Text(DateTimeFormatter.shortDateTime(
                          note.notes[index].createdAt)),
                      content: Text(
                        note.notes[index].content,
                        style: const TextStyle(height: 1.5),
                        textAlign: TextAlign.justify,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      image: 'assets/images/pic1.jpg',
                    ),
                  ),
                ),
              ),
              itemCount: note.notes.length,
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: FloatingActionButton.extended(
          backgroundColor: CustomColor.lavender.value,
          onPressed: () {
            Navigator.of(context).pushNamed(CreateNewNoteScreen.routeName);
          },
          icon: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
            size: 16,
          ),
          label: const Text(
            'Create',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
