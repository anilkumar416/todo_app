import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/core/usecases/usecases.dart';

class AddTodo implements UseCase<void, Todo> {
  final TodoRepository repository;

  AddTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(Todo params) async {
    return await repository.addTodo(params);
  }
}
