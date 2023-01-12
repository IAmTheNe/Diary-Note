import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../models/note.dart';
import '../../utils/theme.dart';
import '../../widgets/note_card.dart';
import '../create_screen/create_note_screen.dart';

class AllNotesTab extends StatelessWidget {
  const AllNotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: ListView.builder(
          itemBuilder: (context, index) =>
              const AnimationConfiguration.staggeredGrid(
            position: 1,
            columnCount: 1,
            duration: Duration(milliseconds: 500),
            child: ScaleAnimation(
              child: FadeInAnimation(
                curve: Curves.easeInCubic,
                child: NoteCard(
                  title: Text(
                    'Lorem ipsum.',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  type: NoteCategory.reminder,
                  createdAt: Text('6 Aug 2020, 07:49 AM'),
                  content: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo tellus et neque euismod, et tristique dolor sagittis. Vestibulum ligula augue, bibendum vel arcu quis, commodo congue velit.',
                    style: TextStyle(height: 1.5),
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  image: 'assets/images/pic1.jpg',
                ),
              ),
            ),
          ),
          itemCount: 20,
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
