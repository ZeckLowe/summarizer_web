import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> chatNames;
  final Function(int) onItemTapped;

  const SideBar({
    super.key,
    required this.selectedIndex,
    required this.chatNames,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    const selectedColor = Color(0xff7077A1);

    return Container(
      width: 250,
      color: Colors.black54,
      child: ListView.builder(
        itemCount: chatNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading:
                index == 0 ? const Icon(Icons.chat, color: Colors.white) : null,
            title: Text(chatNames[index],
                style: const TextStyle(color: Colors.white)),
            onTap: () => onItemTapped(index),
            selected: selectedIndex == index,
            selectedTileColor: selectedColor,
          );
        },
      ),
    );
  }
}
