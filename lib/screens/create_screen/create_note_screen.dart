import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/providers/note_management.dart';
import 'package:provider/provider.dart';
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
  // final _scaffoldMessage = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    time = DateTime.now();
    super.initState();
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
    final note = Note(
      id: '',
      createdAt: time,
      content: content,
      title: title,
    );
    // context.read<NoteManagement>().createNote(note);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
              Text(DateTimeFormatter.shortDateTime(time)),
              const SizedBox(
                height: 16,
              ),
              TextField(
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
