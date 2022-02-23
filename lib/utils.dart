import 'app_export.dart';
import 'package:intl/intl.dart';

Widget situationButton(Situation _situation, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(_situation.name.toUpperCase(),
              style: const TextStyle(fontSize: 18)),
        ),
        onPressed: () {
          Recording recording = Get.put(Recording());
          recording.situation = _situation;
          recording.time = DateTime.now();
          Get.toNamed('/mood');
        }),
  );
}

Widget recordButton(Recording _recording) {
  var formatter = DateFormat('dd. MM. yyyy');
  return ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(formatter.format(_recording.time)),
          Flexible(child: Text(_recording.situation!.name)),
        ],
      ),
      onPressed: () {
        Get.toNamed('/recordInfo', arguments: _recording);
      });
}

class CircleButton extends StatefulWidget {
  final Artefact? artefact;
  const CircleButton({Key? key, required this.artefact}) : super(key: key);

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            widget.artefact!.count++;
          });
        },
        child: Text('${widget.artefact!.abbr}: ${widget.artefact!.count}',
            style: TextStyle(fontSize: 20)),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
          primary: widget.artefact!.color,
          onPrimary: Color(0xFF2B4141),
        ));
  }
}

class Artefact {
  final String name;
  final String abbr;
  final Color color;
  int count;
  Artefact(
      {required this.name,
      required this.abbr,
      required this.color,
      this.count = 0});
}
