import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  final int selectedIndex;  // Accept the selected index

  const MainMenu({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return getMenu(selectedIndex);
  }
}

Widget getMenu(int index){
  switch (index){
    case (0):
      return ConfigMenu();
    case(1):
      return Container();
    case(2):
      return Container();
    case(3):
      return Container();
    case(4):
      return Container();
    default:
      return Container();
  }

}

class ConfigMenu extends StatefulWidget {
  const ConfigMenu({super.key});

  @override
  State<ConfigMenu> createState() => _ConfigMenuState();
}

class _ConfigMenuState extends State<ConfigMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
