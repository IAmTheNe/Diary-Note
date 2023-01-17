import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/utils/date_time_formatter.dart';

class CreateNewNoteScreen extends StatelessWidget {
  const CreateNewNoteScreen({super.key});

  static const routeName = '/create-new-note';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.check_mark),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: CreateNoteSection(),
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
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.music_note,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.photo,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.bell,
                  color: Colors.purple,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
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

class CreateNoteSection extends StatefulWidget {
  const CreateNoteSection({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateNoteSection> createState() => _CreateNoteSectionState();
}

class _CreateNoteSectionState extends State<CreateNoteSection> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late final DateTime time;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
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
    );
  }
}
