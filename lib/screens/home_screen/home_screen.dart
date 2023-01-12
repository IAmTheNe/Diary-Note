import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/theme.dart';
import './all_note_tab.dart';
import './category_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          leading: const SizedBox.shrink(),
          title: const Text('Notes'),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Edit',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: CustomColor.lightGrey.value),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.ellipsis_circle),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'All',
              ),
              Tab(
                text: 'Categories',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllNotesTab(),
            CategoryTab(),
          ],
        ),
      ),
    );
  }
}
