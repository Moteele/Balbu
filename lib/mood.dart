import 'package:balbu1/record.dart';
import 'package:flutter/material.dart';

class Mood extends StatelessWidget {
  final String situation;
  const Mood({Key? key, required this.situation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(situation + ': Jak se citíš?'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MoodButton(
              icon: Icons.sentiment_very_dissatisfied,
              color: Colors.red,
              situation: situation,
            ),
            MoodButton(
              icon: Icons.sentiment_dissatisfied,
              color: Colors.orange,
              situation: situation,
            ),
            MoodButton(
              icon: Icons.sentiment_neutral,
              color: Colors.yellow,
              situation: situation,
            ),
            MoodButton(
              icon: Icons.sentiment_satisfied,
              color: Colors.lightGreen,
              situation: situation,
            ),
            MoodButton(
              icon: Icons.sentiment_very_satisfied,
              color: Colors.green,
              situation: situation,
            ),
          ],
        ),
      ),
    );
  }
}

class MoodButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String situation;
  const MoodButton({Key? key, required this.icon, this.color = Colors.black, required this.situation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyApp(situation: situation)),
          );
        },
        child: Icon(
          icon,
          size: 60,
          color: color,
        ));
  }
}
