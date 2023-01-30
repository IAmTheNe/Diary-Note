import 'package:flutter/cupertino.dart' hide MenuItem;

import '../models/menu_item.dart';

class ListMenu {
  static const setting = MenuItems(
    label: 'Setting',
    icon: CupertinoIcons.gear,
  );

  static const logout = MenuItems(
    label: 'Log out',
    icon: CupertinoIcons.square_arrow_left,
  );

  static const profile = MenuItems(
    label: 'Profile',
    icon: CupertinoIcons.profile_circled,
  );

  static const delete = MenuItems(label: 'Delete');
  static const password = MenuItems(label: 'Lock');

  static const firstMenu = [
    setting,
    profile,
  ];

  static const secondMenu = [
    logout,
  ];

  static const noteAction = [
    delete,
    password,
  ];
}
