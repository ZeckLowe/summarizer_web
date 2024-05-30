import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summarizer_web/models/models.dart';
import 'package:summarizer_web/providers/providers.dart';

class HomePage2 extends ConsumerWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<InputSummary>> summaryAsyncValue =
        ref.watch(summaryProvider);
    ref.watch(summaryProvider);
    final String textDisplay = ref.watch(userTextInput);
    final TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      body: Row(
        children: [
          // Sidebar with chat names
          SideBar(list: summaryAsyncValue),

          // Chat messages and input
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  summaryAsyncValue.when(
                    data: (summaries) {
                      final currentUserId = ref.watch(currentUserIdProvider);
                      final filteredList = summaries
                          .where((summary) => summary.user == currentUserId)
                          .toList();
                      final selectedIndex = ref.watch(selectedIndexProvider);
                      // Check if selectedIndex is valid
                      if (selectedIndex >= 0 &&
                          selectedIndex < filteredList.length) {
                        return Column(
                          children: [
                            Text(
                                "Original Text: ${filteredList[selectedIndex].originalText}"),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                                "Summarized Text: ${filteredList[selectedIndex].summarizedText!}"),
                          ],
                        );
                      } else {
                        return Text('Select a summary to view details');
                      }
                    },
                    loading: () =>
                        CircularProgressIndicator(), // Show loading indicator
                    error: (error, stackTrace) => Text('Error: $error'),
                  ),
                  const Spacer(),
                  TextField(
                    controller: textEditingController,
                    onSubmitted: (value) async {
                      final int userId = ref.watch(currentUserIdProvider);
                      ref.read(userTextInput.notifier).state = value;
                      final String originalText = ref.watch(userTextInput);
                      print(originalText);
                      print("\n");
                      print(userId);
                      await ref
                          .read(summaryCreateProvider.notifier)
                          .createSummary(InputSummary(
                              user: userId, originalText: originalText));
                      ref.read(userTextInput.notifier).state = '';
                      textEditingController.clear();

                      // // Reset the selectedIndexProvider
                      // ref.read(selectedIndexProvider.notifier).state += 1;
                    },
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

class SideBar extends ConsumerWidget {
  SideBar({super.key, required this.list});
  final AsyncValue<List<InputSummary>> list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return list.when(
      loading: () => CircularProgressIndicator(), // Show loading indicator
      error: (error, stackTrace) => Text('Error: $error'), // Show error message
      data: (summaries) {
        final currentUserId = ref.watch(currentUserIdProvider);
        final filteredList = summaries
            .where((summary) => summary.user == currentUserId)
            .toList();
        final selectedIndex = ref.watch(selectedIndexProvider);
        return Container(
          width: 200,
          color: Colors.black54, // Set sidebar color here
          child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(selectedIndexProvider.notifier).state = index;
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Color.fromARGB(255, 152, 152, 152)
                              : null,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                        child: Text(
                          filteredList[index].originalText,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
