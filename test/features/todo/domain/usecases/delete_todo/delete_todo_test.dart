import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/todo/domain/usecases/delete_todo.dart';

import 'delete_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late MockTodoRepository mockTodoRepository;
  late DeleteTodo useCase;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = DeleteTodo(mockTodoRepository);
  });
}
