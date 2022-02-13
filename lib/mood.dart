import 'package:balbu1/db_header.dart';
import 'app_export.dart';

class Mood extends StatelessWidget {
  final Recording recording = Get.find();
  Mood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recording.situation!.name + ': Jak se citíš?'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            MoodButton(
              icon: Icons.sentiment_very_dissatisfied,
              color: Colors.red,
              weight: 1,
            ),
            MoodButton(
              icon: Icons.sentiment_dissatisfied,
              color: Colors.orange,
              weight: 2,
            ),
            MoodButton(
              icon: Icons.sentiment_neutral,
              color: Colors.yellow,
              weight: 3,
            ),
            MoodButton(
              icon: Icons.sentiment_satisfied,
              color: Colors.lightGreen,
              weight: 4,
            ),
            MoodButton(
              icon: Icons.sentiment_very_satisfied,
              color: Colors.green,
              weight: 5,
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
  final int weight;
  const MoodButton(
      {Key? key,
      required this.icon,
      this.color = Colors.black,
      required this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          final Recording recording = Get.find();
          recording.moodBefore = weight;
          Get.toNamed('/recordPage');
        },
        child: Icon(
          icon,
          size: 60,
          color: color,
        ));
  }
}
