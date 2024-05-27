import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int _selectedIndex = 0;
  Color _selectedColor = Color(0xff7077A1);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 250,
            color: Colors.black54,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.black87),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.chat, color: Colors.white),
                  title:
                      Text('New chat', style: TextStyle(color: Colors.white)),
                  onTap: () => _onItemTapped(0),
                  selected: _selectedIndex == 0,
                  selectedTileColor: _selectedColor,
                ),
                ListTile(
                  title: Text('Passing songsList to MusicPlayerVM',
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _onItemTapped(1),
                  selected: _selectedIndex == 1,
                  selectedTileColor: _selectedColor,
                ),
                ListTile(
                  title: Text('Música: Integração Just_Audio',
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _onItemTapped(2),
                  selected: _selectedIndex == 2,
                  selectedTileColor: _selectedColor,
                ),
                Divider(color: Colors.white),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Yesterday',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  title: Text('Null Safety Handle Error',
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _onItemTapped(3),
                  selected: _selectedIndex == 3,
                  selectedTileColor: _selectedColor,
                ),
                ListTile(
                  title: Text('Fetch song using Riverpod.',
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _onItemTapped(4),
                  selected: _selectedIndex == 4,
                  selectedTileColor: _selectedColor,
                ),
                ListTile(
                  title: Text('Django API for Flutter.',
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _onItemTapped(5),
                  selected: _selectedIndex == 5,
                  selectedTileColor: _selectedColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Selected Item: $_selectedIndex',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
