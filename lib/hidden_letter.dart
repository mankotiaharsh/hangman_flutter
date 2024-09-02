import 'package:flutter/material.dart';
import 'package:hangman_flutter/const/const.dart';

Widget hiddenLetter(String char, bool visible) {
  return Container(
    alignment: Alignment.center,
    height: 50,
    width: 50,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child: Visibility(
        visible: visible,
        child: Text(
          char,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.backgroundColor),
        )),
  );
}
