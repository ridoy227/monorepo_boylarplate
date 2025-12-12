import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class AddTodo implements UseCase<void, AddTodoParams> {
  final TodoRepository repository;

  AddTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(AddTodoParams params) async {
    return await repository.addTodo(params.todo);
  }
}

class AddTodoParams extends Equatable {
  final Todo todo;

  const AddTodoParams(this.todo);

  @override
  List<Object> get props => [todo];
}
