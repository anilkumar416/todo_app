import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/todo/domain/usecases/add_todo.dart';

import 'add_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late MockTodoRepository mockTodoRepository;
  late AddTodo addTodo;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    addTodo = AddTodo(mockTodoRepository);
  });

  const todo = Todo(
    id: '1',
    title: 'Test Todo',
    isCompleted: false,
  );

  test('should add a todo successfully', () async {
    when(mockTodoRepository.addTodo(any)).thenAnswer(
      (realInvocation) async => const Right(null),
    );

    final result = await addTodo(todo);

    expect(
      result,
      equals(
        const Right(null),
      ),
    );
    verify(
      mockTodoRepository.addTodo(todo),
    ).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });

  test('should return a failure when adding a todo fails', () async {
    when(mockTodoRepository.addTodo(any)).thenAnswer(
      (realInvocation) async => Left(CacheFailure()),
    );

    final result = await addTodo(todo);
    expect(result, equals(Left(CacheFailure())));
    verify(mockTodoRepository.addTodo(todo)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
