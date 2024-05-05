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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    log("In MyApp build");
    return MultiProvider(
      providers: [
        Provider (create: (context) {
          return Player(playerName: "Virat", jerNo: 18);
        },
        ),
        ChangeNotifierProvider(create: (context){
          return Match(matchNo: 200, runs: 8800);
        }),
      ],
      child: const MaterialApp(
        home: MatchSummary(),
      ),
    );
  }
}

class MatchSummary extends StatefulWidget{
  const MatchSummary({super.key});
  @override
  State createState() => _MatchSummaryState();
}

class _MatchSummaryState extends State{
  @override
  Widget build(BuildContext context){
    log("In MatchSummary Build");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Provider demo"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(Provider.of<Player>(context).playerName),
          const SizedBox(height: 50,),
          Text("${Provider.of<Player>(context).jerNo}"),
          const SizedBox(height: 50,),
          Text("${Provider.of<Match>(context).matchNo}"),
          const SizedBox(height: 50,),
          Text("${Provider.of<Match>(context).runs}"),
          const SizedBox(height: 50,),
          ElevatedButton(onPressed: () {
            Provider.of<Match>(context,listen: false).changeData(250, 8900);
          }, child: const Text("Change Data")),
          const SizedBox(
            height: 20,
          ),
          const NormalClass(),
        ],
      ),
    );
  }
}

class NormalClass extends StatelessWidget{
  const NormalClass({super.key});

  @override 
  Widget build(BuildContext context){
    log("In Normal Class Build");
    return Text("${Provider.of<Match>(context).matchNo}");
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