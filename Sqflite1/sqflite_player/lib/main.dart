import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

dynamic database;

class Player {
  final String name;
  final int jerNo;
  final int runs;
  final double avg;

  Player({
    required this.name,
    required this.jerNo,
    required this.runs,
    required this.avg,
  });


Map<String,dynamic> playerMap() {
  return {
      'name': name,
      'jerNo': jerNo,
      'runs': runs,
      'avg': avg,
    };
}

  @override
  String toString(){
    return '{name: $name,jerNo: $jerNo,runs: $runs, avg: $avg}';
  }
}


Future insertPlayerData(Player obj) async{
  final localDB = await database;

  await localDB.insert(
    "Player",
    obj.playerMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Player>> getPlayerData() async{
  final localDB = await database;

  List<Map<String,dynamic>> listPlayer = await localDB.query("Player");

  return List.generate(listPlayer.length, (i) {
    return Player(
      name: listPlayer[i]['name'],
      jerNo: listPlayer[i]['jerNo'],
      runs: listPlayer[i]['runs'],
      avg: listPlayer[i]['avg'],
    );
  });
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(
  join(await getDatabasesPath(), 'PlayerDB.db'),
  version: 1,
  onCreate: (db, version) async {
    await db.execute(
      '''CREATE TABLE Player(
      (name TEXT, jerNo INTEGER PRIMARY KEY, runs INTEGER, avg REAL)''',
    );
  },
);

  Player batsman1 = Player(
    name: "Virat Kohli",
    jerNo: 18,
    runs:  50000,
    avg: 50.22,
  );

  insertPlayerData(batsman1);
  Player batsman2 = Player(
    name: "Rohit Sharma",
    jerNo: 45,
    runs:  30000,
    avg: 10.22,
  );
  insertPlayerData(batsman2);
  Player batsman3 = Player(
    name: "Shubman Gill",
    jerNo: 77,
    runs:  70000,
    avg: 30.22,
  );
   await insertPlayerData(batsman3);
   print(await getPlayerData());
}
