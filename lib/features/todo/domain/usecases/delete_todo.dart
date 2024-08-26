import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/core/usecases/usecases.dart';

class DeleteTodo implements UseCase<void, String> {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteTodo(id);
  }
}
