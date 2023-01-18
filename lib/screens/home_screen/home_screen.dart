import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart' hide MenuItem;
import 'package:flutter/material.dart' hide MenuItem;
import 'package:note_app/providers/google_sign_in_provider.dart';
import 'package:provider/provider.dart';

import '../../data/menu_list.dart';
import '../../models/menu_item.dart';
import '../../utils/theme.dart';
import '../intro_screen/intro_screen.dart';
import './all_note_tab.dart';
import './category_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const TabSection();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Has some error!'),
          );
        }
        return const IntroductionScreen();
      },
    );
  }
}

class TabSection extends StatelessWidget {
  const TabSection({
    Key? key,
  }) : super(key: key);

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
            PopupMenuButton<MenuItems>(
              onSelected: (value) => onSelected(context, value),
              itemBuilder: (context) => [
                ...ListMenu.firstMenu.map(buildItem).toList(),
                const PopupMenuDivider(),
                ...ListMenu.secondMenu.map(buildItem).toList(),
              ],
              icon: const Icon(CupertinoIcons.ellipsis_circle),
              tooltip: 'More',
              padding: const EdgeInsets.all(4.0),
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

PopupMenuItem<MenuItems> buildItem(MenuItems item) => PopupMenuItem(
      value: item,
      child: Row(
        children: [
          Icon(item.icon),
          const SizedBox(width: 10),
          Text(item.label),
        ],
      ),
    );

void onSelected(BuildContext context, MenuItems item) {
  switch (item) {
    case ListMenu.logout:
      final provider = context.read<GoogleSignInProvider>();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Log out'),
          content: const Text(
            'You will be returned to the Login screen! Are you sure, do you want to continue?',
            style: TextStyle(height: 1.2),
            textAlign: TextAlign.justify,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                style: TextStyle(color: CustomColor.lavender.value),
              ),
            ),
            TextButton(
              onPressed: () async {
                context.read<GoogleSignInProvider>().signOut();
                Navigator.of(context).pop();
              },
              child: Text(
                'Yes',
                style: TextStyle(color: CustomColor.lavender.value),
              ),
            ),
          ],
        ),
      );
      break;
    default:
  }
}
