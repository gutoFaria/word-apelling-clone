//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:word_english_game/allWords.dart';
import 'package:word_english_game/messageBox.dart';

class Controller extends ChangeNotifier{
  int totalLetters = 0, lettersAnswered = 0, wordsAnswered = 0;
  bool generateWord = true, sessionCompleted =false, letterDropped = false;
  double percentCompleted = 0;

  setUp({required int total}){
    // ao criar nova palavra letterAnswered = 0
    lettersAnswered = 0;
    totalLetters = total;
    print('total letters $totalLetters');
    notifyListeners();
  }

  incrementLetters({required BuildContext context}){
    lettersAnswered++;
    updateLetterDropped(dropped: true);
    if(lettersAnswered == totalLetters){
     // AudioPlayer().play(AssetSource('assets/audio/correct_2.mp3'));
      wordsAnswered++;
      percentCompleted = wordsAnswered / allWords.length;
      if(wordsAnswered == allWords.length){
        sessionCompleted = true;
      }
      showDialog(
        barrierDismissible: false,
        context: context, builder: (_) => MessageBox(sessionCompleted: sessionCompleted,));
    }else{
     // AudioPlayer().play(AssetSource('assets/audio/correct_1.mp3'));
    }
    notifyListeners();
  }

  requestWord({required bool request}){
    generateWord = request;
    notifyListeners();
  }

  updateLetterDropped({required bool dropped}){
    letterDropped = dropped;
    notifyListeners();
  }

  reset(){
    sessionCompleted = false;
    wordsAnswered = 0;
    generateWord = true;
    percentCompleted = 0;
  }
}