import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'recordings.db');

  // await deleteDatabase(path);

  final database = openDatabase(
    path,
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE recordings(id INTEGER PRIMARY KEY, situation TEXT)',
      );
    },
    version: 1,
  );

  Future<void> insertRecording(Recording record) async {
    final db = await database;

    await db.insert(
      'recordings',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Recording>> recs() async {
    final db = await database;

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

  var test = Recording(id: 1, situation: "obchod");
  var test1 = Recording(id: 2, situation: "korza");

  await insertRecording(test);
  print(await recs());
  await insertRecording(test1);
  print(await recs());
}

class Recording {
  final int id;
  final String situation;

  Recording({required this.id, required this.situation});
  Map<String, dynamic> toMap() {
    return {'id': id, 'situation': situation};
  }

  @override
  String toString() {
    return 'Recording{id: $id, situation: $situation}';
  }
}

class Situation {
  final String name;
  Situation({required this.name});
}
