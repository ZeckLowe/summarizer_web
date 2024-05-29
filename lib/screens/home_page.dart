import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<String> _chatNames = [];
  Map<int, List<String>> _chatMessages = {};
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch chat names from Django backend
    _fetchChatNames();
  }

  Future<void> _fetchChatNames() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/v1/chats/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _chatNames = data.map((chat) => chat['name']).toList().cast<String>();
      });
    } else {
      throw Exception('Failed to fetch chat names');
    }
  }

  Future<void> _fetchMessages(int chatId) async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/api/v1/chats/$chatId/messages/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _chatMessages[chatId] =
            data.map((message) => message['content']).toList().cast<String>();
      });
    } else {
      throw Exception('Failed to fetch messages for chat $chatId');
    }
  }

  Future<void> _sendMessage(int chatId, String message) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/v1/chats/$chatId/messages/'),
      body: jsonEncode({'content': message}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to send message');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (!_chatMessages.containsKey(index)) {
        _fetchMessages(index);
      }
    });
  }

  void _onSubmitText(String text) async {
    if (_selectedIndex == 0) return; // Don't submit messages to 'New Chat'
    await _sendMessage(_selectedIndex, text);
    setState(() {
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
            decoration: const InputDecoration(
              hintText: 'Chat name',
            ),
            onSubmitted: (chatName) async {
              // Create new chat in Django backend
              final response = await http.post(
                Uri.parse('http://127.0.0.1:8000/api/v1/chats/'),
                body: jsonEncode({'name': chatName}),
                headers: {'Content-Type': 'application/json'},
              );
              if (response.statusCode == 201) {
                setState(() {
                  _chatNames.add(chatName);
                  _selectedIndex = _chatNames.length;
                });
                Navigator.of(context).pop();
              } else {
                throw Exception('Failed to create new chat');
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar with chat names
          _buildSidebar(),
          // Chat messages and input
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // List of messages
                  if (_selectedIndex != 0 &&
                      _chatMessages.containsKey(_selectedIndex))
                    Expanded(
                      child: ListView.builder(
                        itemCount: _chatMessages[_selectedIndex]?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_chatMessages[_selectedIndex]![index]),
                          );
                        },
                      ),
                    ),
                  const Spacer(),
                  // Text input for sending messages
                  TextField(
                    controller: _messageController,
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

  void _editChat(int chatIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedName = _chatNames[chatIndex];
        return AlertDialog(
          title: const Text('Edit chat name'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Edit chat name'),
            onChanged: (value) {
              editedName = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final response = await http.put(
                  Uri.parse(
                      'http://127.0.0.1:8000/api/v1/chats/${chatIndex + 1}/'),
                  body: jsonEncode({'name': editedName}),
                  headers: {'Content-Type': 'application/json'},
                );
                if (response.statusCode == 200) {
                  setState(() {
                    _chatNames[chatIndex] = editedName;
                  });
                  Navigator.of(context).pop();
                } else {
                  throw Exception('Failed to update chat name');
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteChat(int chatIndex) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:8000/api/v1/chats/${chatIndex + 1}/'),
    );
    if (response.statusCode == 204) {
      setState(() {
        _chatNames.removeAt(chatIndex);
        _chatMessages.remove(chatIndex);
        if (_selectedIndex == chatIndex) {
          _selectedIndex = 0; // Select 'New Chat' if current chat is deleted
        }
      });
    } else {
      throw Exception('Failed to delete chat');
    }
  }

  Widget _buildSidebar() {
    return Container(
      width: 200,
      color: Colors.black54, // Set sidebar color here
      child: ListView.builder(
        itemCount: _chatNames.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ListTile(
              leading: index == 0
                  ? const Icon(Icons.chat, color: Colors.white)
                  : null,
              title:
                  Text('New Chat', style: const TextStyle(color: Colors.white)),
              onTap: _onNewChat,
              selected: _selectedIndex == 0,
              tileColor: _selectedIndex == 0
                  ? Colors.white
                  : null, // Change color for selected item
            );
          } else {
            return ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(_chatNames[index - 1]),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white, size: 20),
                    onPressed: () => _editChat(index - 1),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.white, size: 20),
                    onPressed: () => _deleteChat(index - 1),
                  ),
                ],
              ),
              onTap: () => _onItemTapped(index),
              selected: _selectedIndex == index,
              tileColor: _selectedIndex == index
                  ? Colors.white
                  : null, // Change color for selected item
            );
          }
        },
      ),
    );
  }
}
