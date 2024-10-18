import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  final int selectedIndex;  // Accept the selected index

  const MainMenu({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Selected Menu Index: $selectedIndex',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
