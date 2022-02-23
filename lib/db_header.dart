import 'dart:convert';

import 'package:sqflite/sqflite.dart';

class Recording {
  int? id;
  Situation? situation;
  int? moodBefore;
  int? moodAfter = -1;
  String path = '';
  DateTime time = DateTime(0);
  List<String>? artefacts = ['0','0','0','0','0','0','0',];

  Recording();
  Recording.args(
      {this.id,
      this.situation,
      this.moodBefore,
      this.moodAfter,
      this.artefacts,
      required this.path,
      required this.time});

  Map<String, dynamic> toMap() {
    var map = <String, Object?>{
      'situationId': json.encode(situation?.toMap()),
      'moodBefore': moodBefore,
      'moodAfter': moodAfter,
      'path': path,
      'artefacts': artefacts?.join(','),
      'time': time.toString(),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Recording{id: $id, timeL $time, situation: ${situation?.name}, moodBefore: $moodBefore, moodAfter: $moodAfter, path: $path';
  }

  static Future<List<Recording>> getRecordings(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('recordings');

    return List.generate(maps.length, (i) {
      return Recording.args(
          id: maps[i]['id'],
          situation: Situation.fromJson(json.decode(maps[i]['situationId'])),
          moodBefore: maps[i]['moodBefore'],
          moodAfter: maps[i]['moodAfter'],
          path: maps[i]['path'],
          artefacts: maps[i]['artefacts'].split(','),
          time: DateTime.parse(maps[i]['time']));
    });
  }
}

class Situation {
  final String name;
  final int id;
  Situation({required this.id, required this.name});
  Situation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toMap() {
    return <String, Object?>{
      'id': id,
      'name': name,
    };
  }
}

Future<List<Situation>> sits(Database db) async {
  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('situations');

  // Convert the List<Map<String, dynamic> into a List<Situation>.
  return List.generate(maps.length, (i) {
    return Situation(
      id: maps[i]['id'],
      name: maps[i]['name'],
    );
  });
}

Future<Situation> findSituation(Database db, int id) async {
  final List<Map<String, dynamic>> maps =
      await db.query('situations', where: '"id" = ?', whereArgs: ['id']);
  return Situation(
    id: maps[0]['id'],
    name: maps[0]['name'],
  );
}

void createDb(Database db, int version) async {
  Batch batch = db.batch();
  batch.execute("CREATE TABLE situations(id INTEGER PRIMARY KEY, name TEXT);");
  batch.execute(
      "CREATE TABLE recordings(id INTEGER PRIMARY KEY, moodBefore INTEGER, moodAfter INTEGER, artefacts TEXT, path TEXT, time TEXT, situationId TEXT, FOREIGN KEY(situationId) REFERENCES situations(id));");
  batch.execute("INSERT INTO situations(id, name) VALUES(1, 'Čtení')");
  batch.execute("INSERT INTO situations(id, name) VALUES(2, 'Restaurace')");
  batch.execute("INSERT INTO situations(id, name) VALUES(3, 'Obchod')");
  batch.execute("INSERT INTO situations(id, name) VALUES(4, 'Telefonování')");
  batch.execute("INSERT INTO situations(id, name) VALUES(5, 'Prezentace')");
  await batch.commit(noResult: true);
}
