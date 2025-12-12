import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class UpdateTodo implements UseCase<void, UpdateTodoParams> {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateTodoParams params) async {
    return await repository.updateTodo(params.todo);
  }
}

class UpdateTodoParams extends Equatable {
  final Todo todo;

  const UpdateTodoParams(this.todo);

  @override
  List<Object> get props => [todo];
}
