import '../app_export.dart';

class ArtefactsInfo extends StatelessWidget {
  ArtefactsInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> artefacts = [
      ...Get.arguments.entries
          .map(
            (entry) =>
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: CircleAvatar(
                  minRadius: 30,
                  child: Text(
                    entry.value.abbr,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  backgroundColor: entry.value.color,
                ),
              ),
              Text(entry.value.name, style: const TextStyle(fontSize: 16))
            ]),
          )
          .toList()
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Význam zkratek"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: artefacts),
    );
  }
}
