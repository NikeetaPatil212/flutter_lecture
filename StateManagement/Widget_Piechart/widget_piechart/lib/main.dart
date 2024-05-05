import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  Map<String, double> data = {
    "Food": 20,
    "Movies": 10,
    "Entertainment": 40,
  };

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Piechart Demo"),
      ),
     body: Center(
      child: PieChart(
        dataMap: data,
        animationDuration: const Duration(milliseconds: 2000),
        chartType: ChartType.ring,
        chartRadius: 200,
        ringStrokeWidth: 100,
        centerText: "Total",
        chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true),
        legendOptions: const LegendOptions(
          legendPosition: LegendPosition.bottom,
          legendShape: BoxShape.rectangle,
          showLegends: false
        ),
      ),
     ),  
    );
  }
}