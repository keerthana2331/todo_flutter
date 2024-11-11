import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/models/save_task.dart';
import 'package:todo_app_provider/pages/add_todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Consumer<SaveTask>(
            builder: (context, task, child) {
              int completedTasks =
                  task.tasks.where((t) => t.isCompleted).length;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    '$completedTasks/${task.tasks.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.tealAccent,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodo()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<SaveTask>(
        builder: (context, task, child) {
          if (task.tasks.isEmpty) {
            return const Center(
              child: Text(
                'No tasks yet!\nTap + to add a new task',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: task.tasks.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.teal,
              thickness: 1,
            ),
            itemBuilder: (BuildContext context, index) {
              final currentTask = task.tasks[index];

              return Dismissible(
                key: Key(currentTask.title),
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  task.removeTask(currentTask);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${currentTask.title} removed'),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          task.addTask(currentTask);
                        },
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Checkbox(
                      value: currentTask.isCompleted,
                      activeColor: Colors.tealAccent,
                      onChanged: (_) {
                        context.read<SaveTask>().checkTask(index);
                      },
                    ),
                    title: Text(
                      currentTask.title,
                      style: TextStyle(
                        decoration: currentTask.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: currentTask.isCompleted
                            ? Colors.tealAccent.withOpacity(0.6)
                            : Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      currentTask.isCompleted
                          ? Icons.check_circle_outline
                          : Icons.circle_outlined,
                      color: currentTask.isCompleted
                          ? Colors.tealAccent
                          : Colors.grey,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
