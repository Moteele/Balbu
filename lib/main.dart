import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'welcome.dart';
import 'db_header.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'database.db');
  //await deleteDatabase(path);
  final database = await openDatabase(
    path,
    onCreate: createDb,
    version: 1,
  );

  Future<void> insertRecording(Recording record) async {
    final db = database;

    await db.insert(
      'recordings',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Recording>> recs() async {
    final db = database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('recordings');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Recording(
        id: maps[i]['id'],
        situation: maps[i]['situation'],
      );
    });
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

  runApp(MaterialApp(
    home: Welcome(
      db: database,
    ),
    theme: ThemeData(
      //backgroundColor: const Color(0xFF00C4CC),
      scaffoldBackgroundColor: Color(0xFFFFFDF6),
      primaryColor: Color(0xFF2B4141),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.green,).copyWith(
          primary: Color(0xFF2B4141),
          secondary: Color(0xFFC4d6bb),
        ),
        textTheme: GoogleFonts.mulishTextTheme(),
      )
    )
  );
}

