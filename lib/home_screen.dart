import 'package:flutter/material.dart';
import 'package:hangman_flutter/const/const.dart';
import 'package:hangman_flutter/const/dialog_box.dart';
import 'package:hangman_flutter/figure_widget.dart';
import 'package:hangman_flutter/hidden_letter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var characters = "abcdefghijklmnopqrstuvwxyz".toUpperCase();
  var word = "".toUpperCase();
  var hint = "A term often used by internet communities";
  List<String> selectedCharacter = [];
  var tries = 0;

  final dialogScreen = const DialogScreen();

  void resetGame() {
    setState(() {
      tries = 0;
      selectedCharacter.clear();
    });
  }

  void updateWord(String newWord, String newHint) {
    setState(() {
      word = newWord;
      hint = newHint;
      resetGame();
    });
  }

  void resetGameToDefault() {
    resetGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "🅷🅰🅽🅶🅼🅰🅽: 🆃🅷🅴 🅶🅰🅼🅴",
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  dialogScreen.showAddWordDialog(context, updateWord);
                },
                child: const Text("Add Hidden Word"),
              ),
              Text(
                "Lives: ${6 - tries}",
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    word = "";
                    hint = "A term often used by internet communities";
                    resetGameToDefault();
                  });
                },
                child: const Text("Clear All"),
              ),
            ],
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      figure(HangmanUI.hang, tries >= 0),
                      figure(HangmanUI.head, tries >= 1),
                      figure(HangmanUI.body, tries >= 2),
                      figure(HangmanUI.leftArm, tries >= 3),
                      figure(HangmanUI.rightArm, tries >= 4),
                      figure(HangmanUI.leftLeg, tries >= 5),
                      figure(HangmanUI.rightLeg, tries >= 6),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hint: $hint",
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.textColor,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: word
                        .split("")
                        .map((e) =>
                            hiddenLetter(e, selectedCharacter.contains(e)))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 7,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 8.0,
                children: characters.split("").map((e) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(2),
                    ),
                    onPressed: selectedCharacter.contains(e)
                        ? null
                        : () {
                            setState(() {
                              selectedCharacter.add(e);
                              if (!word.split("").contains(e)) {
                                if (tries < 6) {
                                  tries++;
                                }
                                if (tries >= 6) {
                                  dialogScreen.showGameOverDialog(
                                      context, resetGameToDefault);
                                }
                              } else {
                                bool isWordGuessed = word.split("").every(
                                    (element) =>
                                        selectedCharacter.contains(element));
                                if (isWordGuessed) {
                                  dialogScreen.showCongratulationsDialog(
                                      context, resetGameToDefault);
                                }
                              }
                            });
                          },
                    child: Text(
                      e,
                      style: const TextStyle(
                        fontSize: 24,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
