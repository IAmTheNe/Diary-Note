import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/models/people.dart';
import 'package:provider/provider.dart';

import '../../models/note.dart';
import '../../providers/note_management.dart';
import '../../utils/date_time_formatter.dart';

class CreateNewNoteScreen extends StatefulWidget {
  const CreateNewNoteScreen({super.key});

  static const routeName = '/create-new-note';

  @override
  State<CreateNewNoteScreen> createState() => _CreateNewNoteScreenState();
}

class _CreateNewNoteScreenState extends State<CreateNewNoteScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late final DateTime time;
  final _formKey = GlobalKey<FormState>();
  Note? note;
  bool init = false;

  @override
  void initState() {
    _titleController = TextEditingController();
    _contentController = TextEditingController();

    time = DateTime.now();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    note = ModalRoute.of(context)!.settings.arguments as Note?;
    if (!init) {
      _titleController.text = note != null ? note!.title! : '';
      _contentController.text = note != null ? note!.content : '';
    }
    init = true;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> uploadNote() async {
    /// Validating the form and saving the form.
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    final content = _contentController.text;
    final title = _titleController.text;

    if (note == null) {
      final Map<String, dynamic> map = {
        'userId': PeopleSingleton.instance.people!.uid,
        'createdAt': time,
        'content': content,
        'title': title,
      };
      context.read<NoteManagement>().createNote(map);
    } else {
      final updateNote = Note(
        noteId: note!.noteId,
        userId: note!.userId,
        title: _titleController.text,
        createdAt: note!.createdAt,
        content: _contentController.text,
      );
      context.read<NoteManagement>().updateNote(updateNote);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Create new note successfully!'),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: uploadNote,
            icon: const Icon(CupertinoIcons.check_mark),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Title',
                ),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textInputAction: TextInputAction.next,
              ),
              Text(
                DateTimeFormatter.shortDateTime(
                  note == null ? time : note!.createdAt,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                autofocus: true,
                controller: _contentController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note Here',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: height * 0.08,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  CupertinoIcons.music_note,
                  color: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  CupertinoIcons.photo,
                  color: Colors.green,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  CupertinoIcons.bell,
                  color: Colors.purple,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  CupertinoIcons.checkmark_circle,
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
