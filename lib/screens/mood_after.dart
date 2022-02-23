import '../app_export.dart';

class MoodAfter extends StatelessWidget {
  final Recording recording = Get.find();
  MoodAfter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(': Jak se citíš po situaci?'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            MoodAfterButton(
              icon: Icons.sentiment_very_dissatisfied,
              color: Colors.red,
              weight: 1,
            ),
            MoodAfterButton(
              icon: Icons.sentiment_dissatisfied,
              color: Colors.orange,
              weight: 2,
            ),
            MoodAfterButton(
              icon: Icons.sentiment_neutral,
              color: Colors.yellow,
              weight: 3,
            ),
            MoodAfterButton(
              icon: Icons.sentiment_satisfied,
              color: Colors.lightGreen,
              weight: 4,
            ),
            MoodAfterButton(
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

class MoodAfterButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final int weight;
  const MoodAfterButton(
      {Key? key,
      required this.icon,
      this.color = Colors.black,
      required this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          final Database database = Get.find();
          await database.update('recordings', {'moodAfter': '$weight'},
              where: 'id = ?', whereArgs: ['${Get.arguments.id}']);
          Get.toNamed('/listRecords');
        },
        child: Icon(
          icon,
          size: 60,
          color: color,
        ));
  }
}
