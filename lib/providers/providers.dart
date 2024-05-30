import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summarizer_web/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//For Conditional styling of the sidebar selected item
final selectedIndexProvider = StateProvider<int>((ref) => -1);

//login show/hide password icon
final showPassIconProvider = StateProvider<bool>((ref) => true);
final showPassIconProvider2 = StateProvider<bool>((ref) => true);

//signUp textfield controllers
final inputEmailProvider = StateProvider<String>((ref) => '');
final inputPasswordProvider = StateProvider<String>((ref) => '');
final inputConfirmPasswordProvider = StateProvider<String>((ref) => '');

//for storing of users in the database
// final usersAsyncValue = StateProvider<List<User>>((ref) => []);

// //for getting summaries in advance
// final summariesAsyncValue = StateProvider<List<InputSummary>>((ref) => []);

//tracking current user
final currentUserIdProvider = StateProvider<int>((ref) => 0);

//for tracking and resetting textfield display in homepage
final userTextInput = StateProvider<String>((ref) => '');

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

//PERFORM GET REQUEST FROM THE API for USER
final summaryProvider = FutureProvider((ref) async {
  final response =
      await http.get(Uri.http('127.0.0.1:8000', '/api/v1/summary/'));

  if (response.statusCode == 200) {
    final jsonList = jsonDecode(response.body) as List<dynamic>;
    final summaryList =
        jsonList.map((json) => InputSummary.fromJson(json)).toList();

    return summaryList;
  } else {
    throw Exception('Failed to load users: ${response.statusCode}');
  }
});

//PERFORM POST REQUEST FOR SUMMARY
final summaryCreateProvider =
    AsyncNotifierProvider<SummaryCreate, InputSummary>(
  SummaryCreate.new,
);

class SummaryCreate extends AsyncNotifier<InputSummary> {
  @override
  Future<InputSummary> build() async => InputSummary(user: 0, originalText: '');

  Future<void> createSummary(InputSummary summary) async {
    try {
      final response = await http.post(
        Uri.http('127.0.0.1:8000',
            '/api/v1/summary/'), // Replace with your API endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(summary.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Summary created successfully: ${response.body}");
        ref.refresh(summaryProvider);
      } else {
        print(
            "Failed to create summary: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      print("Failed to create summary: $e");
    }
  }
}
