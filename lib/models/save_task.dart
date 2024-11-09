import 'package:flutter/material.dart';
import 'package:todo_app_provider/models/task_model.dart';

class SaveTask extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(title: 'Learn Flutter', isCompleted: true),
    Task(title: 'Drink Water', isCompleted: false),
    Task(title: 'Play Football', isCompleted: true),
    Task(title: 'Add More Todos', isCompleted: false),
  ];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    tasks.remove(task);
    notifyListeners();
  }

  void checkTask(int index) {
    tasks[index].isDone();
    notifyListeners();
  }

  void updateTask(int index, String newTitle) {
    if (index >= 0 && index < tasks.length) {
      tasks[index] = Task(
        title: newTitle,
        isCompleted: tasks[index].isCompleted,
      );
      notifyListeners();
    }
  }

  void editTask(int index, Task updatedTask) {
    if (index >= 0 && index < tasks.length) {
      tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  int getTaskIndex(String title) {
    return tasks.indexWhere((task) => task.title == title);
  }
}
