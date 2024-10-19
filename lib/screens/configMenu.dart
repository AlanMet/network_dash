import 'package:flutter/material.dart';
import 'package:network_dash/widgets/mainmenus.dart';
import 'package:network_dash/widgets/sideMenu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;  // Track selected index

  // Update selected index based on side menu selection
  void _onMenuSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: SideMenuWidget(
                onMenuSelected: _onMenuSelected,  // Pass callback to update selected index
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                color: const Color(0xEE1e201e),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MainMenu(
                    selectedIndex: _selectedIndex,  // Pass the selected index to config menu
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
