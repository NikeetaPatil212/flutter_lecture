import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

dynamic database;

class Employee {
  final int empId;
  final String empName;
  final double sal;

  Employee({
    required this.empId,
    required this.empName,
    required this.sal,
  });


Map<String,dynamic> employeeMap() {
  return {
      'empId': empId,
      'empName': empName,
      'sal': sal,
    };
    
  }
}


Future<void> insertEmployeeData(Employee obj) async{
  final localDB = await database;

  await localDB.insert(
    "Employee",
    obj.employeeMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Map<String,dynamic>>> getEmployeeData() async{
  final localDB = await database;

  List<Map<String,dynamic>> mapEntry = await localDB.query("Employee");

  return mapEntry;
}

Future<void> deleteEmployeeData(Employee emp) async{
  final localDB = await database;
  await localDB.delete(
    "Employee",
    where: "empId = ?",
    whereArgs: [emp.empId],
  );
}


void main() async {
 // WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());

  database = openDatabase(
  join(await getDatabasesPath(), "employeeDB.db"),
  version: 1,
  onCreate: (db, version) async {
    await db.execute(
      '''CREATE TABLE Employee(
        empId INTEGER PRIMARY KEY, 
        empName TEXT,
        sal REAL)''',
    );
  },
);

  Employee emp1 = Employee(
    empId: 1001,
    empName:  "Nikeeta",
    sal: 1.4,
  );

   Employee emp2 = Employee(
    empId: 1002,
    empName:  "Shreya",
    sal: 1.5,
  );

  await insertEmployeeData(emp1);
  await insertEmployeeData(emp2);

  List<Map<String,dynamic>> retVal = await getEmployeeData();
  for(int i = 0; i < retVal.length; i++){
    print(retVal[i]);
  }

  await deleteEmployeeData(emp1);
  print("After Delete");

  retVal = await getEmployeeData();
   for(int i = 0; i < retVal.length; i++){
    print(retVal[i]);
  }

  Employee emp3 = Employee(empId: 1003, empName: "Maria", sal: 1.2);
  await insertEmployeeData(emp3);

  print("Inserted New Data");
  retVal = await getEmployeeData();
  for(int i = 0; i < retVal.length; i++){
    print(retVal[i]);
  }
}

class MainApp extends StatelessWidget{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}