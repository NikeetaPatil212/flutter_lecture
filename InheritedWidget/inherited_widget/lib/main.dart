import 'package:flutter/material.dart';

class SharedData extends InheritedWidget{
  final int data;
  const SharedData({
    super.key,
    required this.data,
    required super.child,
  });

  static SharedData of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<SharedData>()!;
  }

  @override
  bool updateShouldNotify(SharedData oldWidget){
    return data != oldWidget.data;
  }
}
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SharedData(
      data: 50,
      child: MaterialApp(
        home: MainApp(),
      ),
    );
  }
}

class MainApp extends StatefulWidget{
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp>{
  
  @override
  Widget build(BuildContext context){
    SharedData sharedDataObj = SharedData.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("InheritedWidget Demo"),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          Text("${sharedDataObj.data}"),
          const SizedBox(height: 20,),
          const AccessDataWidget(),
        ],
      ),
    );
  }
}

class AccessDataWidget extends StatelessWidget {

  const AccessDataWidget({super.key});
  
  @override
  Widget build(BuildContext context){
    SharedData sharedDataObj = SharedData.of(context);
    return Row(
        children: [
          Text("${sharedDataObj.data}"),
          const SizedBox(width: 20,),
          const AccessDataChild(),
        ],
    );
  }
}

class AccessDataChild extends StatelessWidget {

  const AccessDataChild({super.key});
  
  @override
  Widget build(BuildContext context){
    SharedData sharedDataObj = SharedData.of(context);
    return Row(
        children: [
          Text("${sharedDataObj.data}"),
        ],
    );
  }
}

