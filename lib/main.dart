import 'package:Balbu/routes/app_routes.dart';
import 'package:sqflite_common/sqflite_dev.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'app_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // only for debug
  await databaseFactory.setLogLevel(sqfliteLogLevelVerbose);
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'database4.db');
  //await deleteDatabase(path);
  final database = await openDatabase(
    path,
    onCreate: createDb,
    version: 1,
  );
  Get.put(database, permanent: true);

  runApp(GetMaterialApp(
      initialRoute: AppRoutes.welcome,
      getPages: AppRoutes.pages,
      theme: ThemeData(
        //backgroundColor: const Color(0xFF00C4CC),
        scaffoldBackgroundColor: const Color(0xFFFFFDF6),
        primaryColor: const Color(0xFF2B4141),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          primary: const Color(0xFF2B4141),
          secondary: const Color(0xFFC4d6bb),
        ),
        textTheme: GoogleFonts.mulishTextTheme(),
      )));
}
