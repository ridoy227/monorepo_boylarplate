import 'package:get_it/get_it.dart';
import 'features/todo/data/datasources/todo_local_data_source.dart';
import 'features/todo/data/repositories/todo_repository_impl.dart';
import 'features/todo/domain/repositories/todo_repository.dart';
import 'features/todo/domain/usecases/add_todo.dart';
import 'features/todo/domain/usecases/delete_todo.dart';
import 'features/todo/domain/usecases/get_todos.dart';
import 'features/todo/domain/usecases/update_todo.dart';
import 'features/todo/presentation/providers/todo_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Todo
  // Provider
  sl.registerFactory(
    () => TodoProvider(
      getTodos: sl(),
      addTodo: sl(),
      deleteTodo: sl(),
      updateTodo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTodos(sl()));
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));

  // Repository
  sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(sl()));

  // Data sources
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(),
  );
}
