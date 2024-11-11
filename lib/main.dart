import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/models/save_task.dart';
import 'package:todo_app_provider/pages/add_todo.dart';
import 'package:todo_app_provider/pages/todo_list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SaveTask(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.tealAccent,
        scaffoldBackgroundColor: const Color(0xFF101010),
        fontFamily: 'Montserrat', // Make sure to include this in pubspec.yaml
        appBarTheme: const AppBarTheme(
          elevation: 8,
          titleTextStyle: TextStyle(
            color: Colors.tealAccent,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(color: Colors.tealAccent),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.tealAccent,
          elevation: 6,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadowColor: Colors.black45,
          elevation: 5,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2C2C2C),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.white54),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.tealAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            height: 1.5,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const TodoList(),
        '/add-todo-screen': (_) => const AddTodo(),
      },
    );
  }
}
