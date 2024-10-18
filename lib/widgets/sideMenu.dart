import 'package:flutter/material.dart';
import 'package:network_dash/helper/side_menu_data.dart';

class SideMenuWidget extends StatefulWidget {
  final Function(int) onMenuSelected;  // Accept a callback to notify parent widget

  const SideMenuWidget({super.key, required this.onMenuSelected});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();
    return Container(
      color: const Color(0xFF1e201e),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipOval(
              child: const Image(
                image: AssetImage("assets/images/logo green.png"),
                height: 150,
                width: 150,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.menu.length,
              itemBuilder: (context, index) {
                // Check if we are at the second-to-last item
                if (index == data.menu.length - 2) {
                  return Column(
                    children: [
                      buildMenuEntry(data, index), // Regular second-to-last item
                      const SizedBox(height: 50),  // Add large gap before the last item (Log Out)
                    ],
                  );
                } else {
                  return buildMenuEntry(data, index);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Method to build the standard menu entry
  Widget buildMenuEntry(SideMenuData data, int index) {
    final isSelected = index == selectedIndex;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        widget.onMenuSelected(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF697565) : const Color(0xFF697565),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          child: Row(
            children: [
              data.menu[index].icon,
              const SizedBox(width: 10),
              Text(
                data.menu[index].title,
                style: TextStyle(
                  fontSize: 20,
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
