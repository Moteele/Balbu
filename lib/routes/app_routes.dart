import 'package:Balbu/mood_before.dart';
import 'package:Balbu/record.dart';
import 'package:Balbu/screens/artefacts_info.dart';
import 'package:Balbu/screens/mood_after.dart';
import 'package:Balbu/screens/record_info.dart';
import 'package:Balbu/situations.dart';
import 'package:Balbu/welcome.dart';
import 'package:get/get.dart';
import '../screens/list_records.dart';

class AppRoutes {
  static String welcome = '/welcome';
  static String situations = '/situations';
  static String mood = '/mood';
  static String moodAfter = '/moodAfter';
  static String recordPage = '/recordPage';
  static String listRecords = '/listRecords';
  static String recordInfo = '/recordInfo';
  static String artefactsInfo = '/artefactsInfo';

  static List<GetPage> pages = [
    GetPage(
      name: welcome,
      page: () => Welcome(),
    ),
    GetPage(name: situations, page: () => Situations()),
    GetPage(name: mood, page: () => Mood()),
    GetPage(name: recordPage, page: () => RecordPage()),
    GetPage(name: listRecords, page: () => ListRecords()),
    GetPage(name: recordInfo, page: () => RecordInfo()),
    GetPage(name: moodAfter, page: () => MoodAfter()),
    GetPage(name: artefactsInfo, page: () => ArtefactsInfo()),
  ];
}
