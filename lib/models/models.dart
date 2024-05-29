class User {
  final int? id;
  final String email;
  final String password;

  User({
    required this.email,
    required this.password,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class Chat {
  final int id;
  final String name;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.name,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    var messagesFromJson = json['messages'] as List;
    List<Message> messageList =
        messagesFromJson.map((i) => Message.fromJson(i)).toList();

    return Chat(
      id: json['id'],
      name: json['name'],
      messages: messageList,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'messages': messages.map((message) => message.toJson()).toList(),
      };
}

class Message {
  final int id;
  final int chatId;
  final String text;
  final String timestamp;

  Message(
      {required this.id,
      required this.chatId,
      required this.text,
      required this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        chatId: json['chatId'],
        text: json['text'],
        timestamp: json['timestamp']);
  }

  Map<String, dynamic> toJson() => {
        'chat': chatId,
        'text': text,
        'timestamp': timestamp,
      };
}
