import 'package:flutter/material.dart';

import 'configurationwidgets.dart';

class MainMenu extends StatelessWidget {
  final int selectedIndex; // Accept the selected index

  const MainMenu({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return getMenu(selectedIndex);
  }
}

Widget getMenu(int index) {
  switch (index) {
    case (0):
      // config
      return const ConfigMenu();
    case (1):
      //training
      return Container();
    case (2):
      //stats
      return Container();
    case (3):
      //models
      return Container();
    case (4):
      //logout
      return Container();
    default:
      return Container();
  }
}
