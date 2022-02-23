import 'package:balbu1/mood_before.dart';
import 'package:balbu1/record.dart';
import 'package:balbu1/screens/mood_after.dart';
import 'package:balbu1/screens/record_info.dart';
import 'package:balbu1/situations.dart';
import 'package:balbu1/welcome.dart';
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
  ];
}
