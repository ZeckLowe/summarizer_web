import 'package:flutter/material.dart';

class ChatInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3, // Placeholder for dynamic chat messages
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Chat Message $index'),
        );
      },
    );
  }
}
