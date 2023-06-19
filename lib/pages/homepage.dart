import 'package:flutter/material.dart';
import 'package:to_do_2/util/database.dart';
import 'package:to_do_2/util/dialogbox.dart';
import 'package:to_do_2/util/todotile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('myBox'); // refer to box create
  Database db = Database(); // instance of data storage class

  // text field controller
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // label task as complete by slashing it
  void crossTask(int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  // add task to list of tasks
  void saveTask() {
    setState(() {
      db.toDoList.add([controller.text, false]);
    });
    Navigator.pop(context);
    controller.clear();
    db.updateData();
  }

  // delete individual task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  // wipes all the tasks clear
  void clearTask() {
    setState(() {
      db.toDoList.clear();
    });
    db.updateData();
  }

  // method for when plus sign to add new task is clicked
  void newTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          onCancel: () {
            Navigator.of(context).pop();
            controller.clear();
          },
          onSave: saveTask,
          controller: controller,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      drawer: Drawer(
        backgroundColor: Colors.purple[200],
      ),
      appBar: AppBar(
        title: const Center(child: Text('TO DO')),
        actions: [
          TextButton(
            onPressed: clearTask,
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            isComplete: db.toDoList[index][1],
            onChanged: (context) => crossTask(index),
            onDelete: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: newTask,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
