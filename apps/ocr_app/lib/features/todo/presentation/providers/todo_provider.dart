import 'package:flutter/material.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/update_todo.dart';

class TodoProvider extends ChangeNotifier {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final UpdateTodo updateTodo;

  TodoProvider({
    required this.getTodos,
    required this.addTodo,
    required this.deleteTodo,
    required this.updateTodo,
  });

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadTodos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getTodos(NoParams());

    result.fold(
      (failure) {
        _errorMessage = 'Failed to load todos';
        _isLoading = false;
        notifyListeners();
      },
      (todos) {
        _todos = todos;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> addTodoItem(String title) async {
    final todo = Todo(title: title, isCompleted: false);
    final result = await addTodo(AddTodoParams(todo));

    result.fold(
      (failure) {
        _errorMessage = 'Failed to add todo';
        notifyListeners();
      },
      (_) {
        loadTodos();
      },
    );
  }

  Future<void> deleteTodoItem(int id) async {
    final result = await deleteTodo(DeleteTodoParams(id));

    result.fold(
      (failure) {
        _errorMessage = 'Failed to delete todo';
        notifyListeners();
      },
      (_) {
        loadTodos();
      },
    );
  }

  Future<void> toggleTodoCompletion(Todo todo) async {
    final updatedTodo = Todo(
      id: todo.id,
      title: todo.title,
      isCompleted: !todo.isCompleted,
    );
    final result = await updateTodo(UpdateTodoParams(updatedTodo));

    result.fold(
      (failure) {
        _errorMessage = 'Failed to update todo';
        notifyListeners();
      },
      (_) {
        loadTodos();
      },
    );
  }
}
