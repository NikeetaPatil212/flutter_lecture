import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    log("In MainApp Build");
    return MultiProvider(providers: [
      Provider(create: (context){
        return Player(playerName: "Virat",jerNo: 18);
      },),
      ChangeNotifierProvider(create: (context){
        return Match(matchNo: 200, runs: 8800);
      }),
    ],
    child: MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Provider demo"),
        ),
        body: Consumer<Match>(
          builder: (context,value,child){
            log("In Consumer");
            return Center(
              child: Text(Provider.of<Player>(context).playerName),
            );
          },
        )
      ),
    )
    );
  }
}


class Player{
  String playerName;
  int jerNo;

  Player({required this.playerName, required this.jerNo});
}

class Match with ChangeNotifier{
  int matchNo;
  int runs;

  Match({required this.matchNo, required this.runs});

  void changeData(int matchNo, int runs){
    this.matchNo = matchNo;
    this.runs = runs;
    notifyListeners();
  }
}