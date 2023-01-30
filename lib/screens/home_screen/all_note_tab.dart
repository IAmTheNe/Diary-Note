import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../data/menu_list.dart';
import '../../models/menu_item.dart';
import '../../models/note.dart';
import '../../providers/app_state.dart';
import '../../providers/note_management.dart';
import '../../utils/date_time_formatter.dart';
import '../../utils/theme.dart';
import '../../widgets/note_card.dart';
import '../create_screen/create_note_screen.dart';

class AllNotesTab extends StatelessWidget {
  const AllNotesTab({super.key});

  void showContextMenu(BuildContext context, Note note) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 150,
        child: Card(
          child: ListView(
            children: [
              ...ListMenu.noteAction
                  .map((items) => buildItem(context, items, note))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

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
                    child: GestureDetector(
                      onLongPress: () =>
                          showContextMenu(context, note.notes[index]),
                      child: NoteCard(
                        title: Text(
                          note.notes[index].title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        type: NoteCategory.reminder,
                        createdAt: Text(
                          DateTimeFormatter.shortDateTime(
                            note.notes[index].createdAt,
                          ),
                        ),
                        content: Text(
                          note.notes[index].content,
                          style: const TextStyle(height: 1.5),
                          textAlign: TextAlign.justify,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        image: null,
                      ),
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

  Widget buildItem(BuildContext context, MenuItems items, Note note) {
    return ListTile(
      onTap: () => onTap(context, items, note),
      title: Text(items.label),
    );
  }

  void onTap(BuildContext context, MenuItems items, Note note) {
    switch (items) {
      case ListMenu.delete:
        context.read<NoteManagement>().deleteNote(note);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Delete this note successfully!'),
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.horizontal,
            ),
          );
        Navigator.pop(context);
        break;
      default:
    }
  }
}
