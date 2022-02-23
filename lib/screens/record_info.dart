import 'package:balbu1/play_widget.dart';

import '../app_export.dart';
import 'package:just_audio/just_audio.dart' as ap;

class RecordInfo extends StatefulWidget {
  RecordInfo({Key? key}) : super(key: key);

  @override
  State<RecordInfo> createState() => _RecordInfoState();
}

class _RecordInfoState extends State<RecordInfo> {
  Recording recording = Get.arguments;

  Map<String, Artefact> artefacts = {};

  @override
  void initState() {
    super.initState();
    artefacts = {
      'B': Artefact(
          abbr: 'B',
          name: 'Bloky',
          count: int.parse(recording.artefacts![0]),
          color: const Color(0xFFC4d6bb)),
      'R': Artefact(
          abbr: 'R',
          name: 'Repetice',
          count: int.parse(recording.artefacts![1]),
          color: const Color(0xFFC4d6bb)),
      'P': Artefact(
          abbr: 'P',
          name: 'Prolongace',
          count: int.parse(recording.artefacts![2]),
          color: const Color(0xFFC4d6bb)),
      'VO': Artefact(
          abbr: 'VO',
          name: 'Volné opakování',
          count: int.parse(recording.artefacts![3]),
          color: const Color(0xFFFFCAA3)),
      'C': Artefact(
          abbr: 'C',
          name: 'Cancellation',
          count: int.parse(recording.artefacts![4]),
          color: const Color(0xFFFFCAA3)),
      'PO': Artefact(
          abbr: 'PO',
          name: 'Pull out',
          count: int.parse(recording.artefacts![5]),
          color: const Color(0xFFFFCAA3)),
      'MZ': Artefact(
          abbr: 'MZ',
          name: 'Měkký hlasový začátek',
          count: int.parse(recording.artefacts![6]),
          color: const Color(0xFFFFCAA3)),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(Get.arguments.situation.name)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: AudioPlayer(
                source: ap.AudioSource.uri(Uri.parse(Get.arguments.path)),
                onDelete: () {},
                showTrash: false,
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleButton(artefact: artefacts['B']),
                CircleButton(artefact: artefacts['R']),
                CircleButton(artefact: artefacts['P']),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleButton(artefact: artefacts['VO']),
                CircleButton(artefact: artefacts['C']),
                CircleButton(artefact: artefacts['PO']),
                CircleButton(artefact: artefacts['MZ']),
              ],
            ),
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: const Size.fromWidth(200)),
                    onPressed: () {
                      setState(() {
                        artefacts.forEach((key, value) {
                          value.count = 0;
                        });
                      });
                    },
                    child:
                        const Text('Vynulovat', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: const Size.fromWidth(200)),
                    onPressed: () async {
                      final Database database = Get.find();
                      String newValue = """
                    ${artefacts['B']?.count},
                    ${artefacts['R']?.count},
                    ${artefacts['P']?.count},
                    ${artefacts['VO']?.count},
                    ${artefacts['C']?.count},
                    ${artefacts['PO']?.count},
                    ${artefacts['MZ']?.count}
                    """;
                      await database.update(
                          'recordings', {'artefacts': newValue},
                          where: 'id = ?', whereArgs: ['${Get.arguments.id}']);
                      Get.toNamed('/listRecords');
                    },
                    child: const Text('Ulož', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
            ]),
          ],
        ));
  }
}
