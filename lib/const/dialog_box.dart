import 'package:flutter/material.dart';

class DialogScreen extends StatelessWidget {
  const DialogScreen({super.key});

  void showGameOverDialog(BuildContext context, VoidCallback resetGame) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: const Text("You've run out of lives....."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: const Text("Reset"),
            )
          ],
        );
      },
    );
  }

  void showCongratulationsDialog(BuildContext context, VoidCallback resetGame) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: const Text("You've guessed the word!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: const Text("Reset"),
            )
          ],
        );
      },
    );
  }

  void showAddWordDialog(
      BuildContext context, Function(String, String) updateWord) {
    String newWord = '';
    String newHint = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Hidden Word"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    newWord = value.toUpperCase();
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter Hidden Word',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    newHint = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter Hint',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                updateWord(newWord, newHint);
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
