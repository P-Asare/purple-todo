import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final TextEditingController controller;

  const DialogBox({
    super.key,
    required this.onSave,
    required this.onCancel,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.purple[200],
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Add task',
                border: OutlineInputBorder(),
              ),
              controller: controller,
            ),
            Row(
              // push buttons to right of text field
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Save button
                MaterialButton(
                  onPressed: onSave,
                  color: Colors.purple,
                  child: const Text('Save'),
                ),
                //spacing
                const SizedBox(
                  width: 12,
                ),
                // Cancel button
                MaterialButton(
                  onPressed: onCancel,
                  color: Colors.purple,
                  child: const Text('Cancel'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
