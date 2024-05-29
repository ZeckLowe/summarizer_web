import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summarizer_web/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//login show/hide password icon
final showPassIconProvider = StateProvider<bool>((ref) => true);
final showPassIconProvider2 = StateProvider<bool>((ref) => true);

//signUp textfield controllers
final inputEmailProvider = StateProvider<String>((ref) => '');
final inputPasswordProvider = StateProvider<String>((ref) => '');
final inputConfirmPasswordProvider = StateProvider<String>((ref) => '');

//for storing of users in the database
final usersAsyncValue = StateProvider<List<User>>((ref) => []);

//tracking current user
final currentUserIdProvider = StateProvider<int>((ref) => 0);

//PERFORM GET REQUEST FROM THE API for USER
final userProvider = FutureProvider((ref) async {
  final response = await http.get(Uri.http('127.0.0.1:8000', '/api/v1/user/'));

  if (response.statusCode == 200) {
    final jsonList = jsonDecode(response.body) as List<dynamic>;
    final userList = jsonList.map((json) => User.fromJson(json)).toList();

    return userList;
  } else {
    throw Exception('Failed to load users: ${response.statusCode}');
  }
});

// PERFORM POST REQUEST for USER
final userCreateProvider = AsyncNotifierProvider<UserCreate, User>(
  UserCreate.new,
);

class UserCreate extends AsyncNotifier<User> {
  @override
  Future<User> build() async => User(email: '', password: '');

  Future<void> addUser(User user) async {
    try {
      final response = await http.post(
        Uri.http('127.0.0.1:8000', '/api/v1/user/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User added successfully: ${response.body}");
        ref.refresh(userProvider);
      } else {
        print("Failed to add user: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      print("Failed to add user: $e");
    }
  }
}
