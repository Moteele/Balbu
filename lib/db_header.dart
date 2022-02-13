import 'package:sqflite/sqflite.dart';

class Recording {
  int? id;
  Situation? situation;
  int? moodBefore;
  String? path;

  Recording();
  Recording.args({this.id, this.situation, this.moodBefore, this.path});

  Map<String, dynamic> toMap() {
    var map = <String, Object?>{
      'situationId': situation?.id,
      'moodBefore': moodBefore,
      'path': path,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Recording{id: $id, situation: $situation.name}, moodBefore: $moodBefore, path: $path';
  }

  static Future<List<Recording>> get_recordings(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('recordings');
    List<Situation> _sits = await sits(db);
    Map<int, Situation> _map = {};
    for (var element in _sits) {
      _map[element.id] = element;
    }

    return List.generate(maps.length, (i) {
      return Recording.args(
          id: maps[i]['id'],
          situation: _map[maps[i]['SituationId']],
          moodBefore: maps[i]['moodBefore'],
          path: maps[i]['path']);
    });
  }
}

class Situation {
  final String name;
  final int id;
  Situation({required this.id, required this.name});
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
      "CREATE TABLE recordings(id INTEGER PRIMARY KEY, situation_id INTEGER, FOREIGN KEY(situation_id) REFERENCES situations(id));");
  batch.execute("INSERT INTO situations(id, name) VALUES(1, 'Čtení')");
  batch.execute("INSERT INTO situations(id, name) VALUES(2, 'Restaurace')");
  batch.execute("INSERT INTO situations(id, name) VALUES(3, 'Obchod')");
  batch.execute("INSERT INTO situations(id, name) VALUES(4, 'Telefonování')");
  batch.execute("INSERT INTO situations(id, name) VALUES(5, 'Prezentace')");
  await batch.commit(noResult: true);
}
