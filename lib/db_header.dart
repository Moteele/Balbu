import 'package:sqflite/sqflite.dart';

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

void createDb(Database db, int version) async {
  Batch batch = db.batch();
  batch.execute("CREATE TABLE situations(id INTEGER PRIMARY KEY, name TEXT);");
  batch.execute("CREATE TABLE recordings(id INTEGER PRIMARY KEY, situation_id INTEGER, FOREIGN KEY(situation_id) REFERENCES situations(id));");
  batch.execute("INSERT INTO situations(id, name) VALUES(1, 'Čtení')");
  batch.execute("INSERT INTO situations(id, name) VALUES(2, 'Restaurace')");
  batch.execute("INSERT INTO situations(id, name) VALUES(3, 'Obchod')");
  batch.execute("INSERT INTO situations(id, name) VALUES(4, 'Telefonování')");
  batch.execute("INSERT INTO situations(id, name) VALUES(5, 'Prezentace')");
  await batch.commit(noResult: true);
}
