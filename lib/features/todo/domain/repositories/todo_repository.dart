import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
  Future<Either<Failure, void>> addTodo(Todo todo);
  Future<Either<Failure, void>> updateTodo(Todo todo);
  Future<Either<Failure, void>> deleteTodo(String id);
}
