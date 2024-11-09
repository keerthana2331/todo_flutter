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

  void _saveTask(BuildContext context) {
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
        title: Text(widget.taskToEdit != null ? 'Edit Todo' : 'Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller,
              autofocus: widget.taskToEdit == null,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            CheckboxListTile(
              title: const Text('Mark as completed'),
              value: isCompleted,
              onChanged: (value) {
                setState(() {
                  isCompleted = value ?? false;
                });
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => _saveTask(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                widget.taskToEdit != null ? 'Update' : 'Add',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
