import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addTodo(Todo todo) async {
    try {
      final todoModel = TodoModel(
          id: todo.id, title: todo.title, isCompleted: todo.isCompleted);
      await localDataSource.addTodo(todoModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    try {
      await localDataSource.deleteTodo(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final todos = await localDataSource.getTodos();
      return Right(todos);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) async {
    try {
      final todoModel = TodoModel(
          id: todo.id, title: todo.title, isCompleted: todo.isCompleted);
      await localDataSource.updateTodo(todoModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
