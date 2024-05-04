import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

dynamic database;

class Zomato {
  int? orderNo;
  final String custName;
  final String hotelName;
  final String food;
  final double bill;

  Zomato({
    this.orderNo,
    required this.custName,
    required this.hotelName,
    required this.food,
    required this.bill,
  });


Map<String,dynamic> zomatoMap() {
  return {
      'custName': custName,
      'hotelName': hotelName,
      'food': food,
      'bill': bill,
    };
}

  @override
  String toString(){
    return '{orderNo: $orderNo, custName: $custName,hotelName: $hotelName,food: $food, bill: $bill}';
  }
}


Future<void> insertOrderData(Zomato obj) async{
  final localDB = await database;

  await localDB.insert(
    "OrderFood",
    obj.zomatoMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Zomato>> getOrderData() async{
  final localDB = await database;

  List<Map<String,dynamic>> orderMap = await localDB.query("OrderFood");

  return List.generate(orderMap.length, (i) {
    return Zomato(
      orderNo: orderMap[i]['orderNo'],
      custName: orderMap[i]['custName'],
      hotelName: orderMap[i]['hotelName'],
      food: orderMap[i]['food'],
      bill: orderMap[i]['bill'],
    );
  });
}

Future<void> deleteOrderData(int data) async{
  final localDB = await database;
  await localDB.delete(
    "OrderFood",
    where: "orderNo = ?",
    whereArgs: [data],
  );
}

Future<void> updateOrderData(Zomato obj) async{
  final localDB = await database;
  await localDB.update(
    "OrderFood",
    obj.zomatoMap(),
    where: 'orderNo=?',
    whereArgs: [obj.orderNo],
  );
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(
  join(await getDatabasesPath(), 'BlinkDB.db'),
  version: 1,
  onCreate: (db, version) async {
    await db.execute(
      '''CREATE TABLE OrderFood(
        orderNo INTEGER PRIMARY KEY, 
        custName TEXT, 
        hotelName TEXT,
        food TEXT,
        bill REAL)''',
    );
  },
);

  Zomato order1 = Zomato(
    custName: "Nikeeta",
    hotelName: "DelhiWale",
    food:  "Paneer masala",
    bill: 830.22,
  );

  insertOrderData(order1);
  Zomato order2 = Zomato(
    custName: "Shreya",
    hotelName: "Zeeshan Biryani",
    food:  "Biryan",
    bill: 330.22,
  );

  insertOrderData(order2);

 Zomato order3 = Zomato(
    custName: "Maria",
    hotelName: "Crazy Cheezy",
    food:  "Pizza",
    bill: 300.22,
  );

  insertOrderData(order3);
  print(await getOrderData());

  deleteOrderData(3);
  print(await getOrderData());

  order1 = Zomato(
    orderNo: order1.orderNo,
    custName: order1.custName, 
    hotelName: order1.hotelName, 
    food: "${order1.food}Burger", 
    bill: order1.bill + 150.00);

    updateOrderData(order1);
    print(await getOrderData());
}

