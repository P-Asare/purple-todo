import 'package:hive_flutter/hive_flutter.dart';

class Database {
  // Class to store the data being used and uploads and saves data

  List toDoList = [];

  final _myBox = Hive.box('myBox'); // reference to hive box

  void createInitialData() {
    toDoList = [
      ["Wash bathroom", false],
      ["Play football", false],
    ];
  }

  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  void updateData() {
    _myBox.put('TODOLIST', toDoList);
  }
}
