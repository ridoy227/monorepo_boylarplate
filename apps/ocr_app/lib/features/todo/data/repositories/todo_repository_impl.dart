import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data_source.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final localTodos = await localDataSource.getTodos();
      return Right(localTodos);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addTodo(Todo todo) async {
    try {
      final todoModel = TodoModel(
        id: todo.id,
        title: todo.title,
        isCompleted: todo.isCompleted,
      );
      await localDataSource.addTodo(todoModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(int id) async {
    try {
      await localDataSource.deleteTodo(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) async {
    try {
      final todoModel = TodoModel(
        id: todo.id,
        title: todo.title,
        isCompleted: todo.isCompleted,
      );
      await localDataSource.updateTodo(todoModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
