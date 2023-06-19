import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool isComplete;
  final Function(bool?)? onChanged;
  final Function(BuildContext) onDelete;

  const ToDoTile(
      {super.key,
      required this.taskName,
      required this.isComplete,
      required this.onChanged,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 25,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(15),
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Checkbox(
                  activeColor: Colors.green[200],
                  checkColor: Colors.black,
                  value: isComplete,
                  onChanged: onChanged,
                ),
                (isComplete)
                    ? Text(
                        taskName,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.black,
                          decorationThickness: 3.0,
                          fontSize: 18,
                        ),
                      )
                    : Text(
                        taskName,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
