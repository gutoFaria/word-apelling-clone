import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_english_game/controller.dart';
import 'package:word_english_game/homepage.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({super.key, required this.sessionCompleted});

  final bool sessionCompleted;

  @override
  Widget build(BuildContext context) {
    String title = "Well Done!";
    String buttonText = "New Word";

    if (sessionCompleted) {
      title = "All Words Completed";
      buttonText = "Replay";
    }

    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        backgroundColor: Colors.amberAccent,
        title: Text(title, style: Theme.of(context).textTheme.displayLarge),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
              onPressed: () {
                if (sessionCompleted) {
                  Provider.of<Controller>(context, listen: false).reset();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                } else {
                  Provider.of<Controller>(context, listen: false)
                      .requestWord(request: true);
                  // fazer box desaparecer
                  Navigator.of(context).pop();
                }
              },
              child: Text(buttonText,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 30, color: Colors.amber)))
        ]);
  }
}
