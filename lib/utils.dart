import 'app_export.dart';

Widget situationButton(Situation _situation, BuildContext context) {
  return ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(_situation.name)),
          Container(child: Text('0')),
        ],
      ),
      onPressed: () {
        Recording recording = Get.put(Recording());
        recording.situation = _situation;
        recording.time = DateTime.now();
        Get.toNamed('/mood');
      });
}

Widget recordButton(Recording _recording) {
  return ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(_recording.situation!.name)),
          Container(child: Text('0')),
        ],
      ),
      onPressed: () {});
}
