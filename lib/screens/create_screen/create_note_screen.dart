import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewNoteScreen extends StatelessWidget {
  const CreateNewNoteScreen({super.key});

  static const routeName = '/create-new-note';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.check_mark),
          ),
        ],
      ),
    );
  }
}
