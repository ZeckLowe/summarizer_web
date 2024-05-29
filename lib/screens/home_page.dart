import 'package:flutter/material.dart';
import 'side_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<String> _chatNames = ['New Chat'];
  Map<int, List<String>> _chatMessages = {};
  TextEditingController _chatNameController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSubmitText(String text) {
    setState(() {
      if (!_chatMessages.containsKey(_selectedIndex)) {
        _chatMessages[_selectedIndex] = [];
      }
      _chatMessages[_selectedIndex]!.add(text);
    });
  }

  void _onNewChat() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter chat name'),
          content: TextField(
            controller: _chatNameController,
            decoration: const InputDecoration(
              hintText: 'Chat name',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _chatNames.add(_chatNameController.text);
                  _selectedIndex = _chatNames.length - 1;
                  _chatMessages[_selectedIndex] = [];
                  _chatNameController.clear();
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(
            selectedIndex: _selectedIndex,
            chatNames: _chatNames,
            onItemTapped: (index) {
              if (index == 0) {
                _onNewChat();
              } else {
                _onItemTapped(index);
              }
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_selectedIndex != 0)
                    Expanded(
                      child: ListView.builder(
                        itemCount: _chatMessages[_selectedIndex]?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_chatMessages[_selectedIndex]![index]),
                          );
                        },
                      ),
                    ),
                  const Spacer(),
                  TextField(
                    onSubmitted: _onSubmitText,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter text',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
