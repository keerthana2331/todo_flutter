import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/models/save_task.dart';
import 'package:todo_app_provider/models/task_model.dart';

class AddTodo extends StatefulWidget {
  final Task? taskToEdit;
  final int? editIndex;

  const AddTodo({
    super.key,
    this.taskToEdit,
    this.editIndex,
  });

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  late final TextEditingController controller;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.taskToEdit?.title ?? '');
    isCompleted = widget.taskToEdit?.isCompleted ?? false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void saveTask(BuildContext context) {
    if (controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a title'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final taskProvider = context.read<SaveTask>();

    if (widget.taskToEdit != null && widget.editIndex != null) {
      taskProvider.editTask(
        widget.editIndex!,
        Task(
          title: controller.text.trim(),
          isCompleted: isCompleted,
        ),
      );
    } else {
      taskProvider.addTask(
        Task(
          title: controller.text.trim(),
          isCompleted: isCompleted,
        ),
      );
    }

    controller.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.taskToEdit != null ? 'Edit Todo' : 'Add Todo',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal, // Set the app bar color to teal
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title input field
            TextField(
              controller: controller,
              autofocus: widget.taskToEdit == null,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Enter task title...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.teal, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                prefixIcon: const Icon(
                  Icons.task_alt,
                  color: Colors.teal,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Checkbox to mark task as completed
            CheckboxListTile(
              title: const Text(
                'Mark as completed',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              activeColor: Colors.tealAccent,
              value: isCompleted,
              onChanged: (value) {
                setState(() {
                  isCompleted = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            ),
            const SizedBox(height: 30),

            // Add or Update task button
            ElevatedButton(
              onPressed: () => saveTask(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                iconColor: Colors.teal, // Set the button color
                elevation: 5,
              ),
              child: Text(
                widget.taskToEdit != null ? 'Update Task' : 'Add Task',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
