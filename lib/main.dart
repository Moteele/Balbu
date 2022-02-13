import 'package:balbu1/routes/app_routes.dart';
import 'package:sqflite_common/sqflite_dev.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'app_export.dart';
import 'db_header.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // only for debug
  await databaseFactory.setLogLevel(sqfliteLogLevelVerbose);
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'database.db');
  await deleteDatabase(path);
  final database = await openDatabase(
    path,
    onCreate: createDb,
    version: 1,
  );
  Get.put(database);

  Future<void> insertRecording(Recording record) async {
    final db = database;

    await db.insert(
      'recordings',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Situation>> situations() async {
    final db = database;
    final List<Map<String, dynamic>> maps = await db.query('situations');
    return List.generate(maps.length, (i) {
      return Situation(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  runApp(GetMaterialApp(
      initialRoute: AppRoutes.welcome,
      getPages: AppRoutes.pages,
      theme: ThemeData(
        //backgroundColor: const Color(0xFF00C4CC),
        scaffoldBackgroundColor: Color(0xFFFFFDF6),
        primaryColor: Color(0xFF2B4141),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          primary: Color(0xFF2B4141),
          secondary: Color(0xFFC4d6bb),
        ),
        textTheme: GoogleFonts.mulishTextTheme(),
      )));
}
