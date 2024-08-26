import 'package:bloc/bloc.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/usecases/usecases.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/usecases/get_todos.dart';

part 'get_todos_event.dart';
part 'get_todos_state.dart';

class GetTodosBloc extends Bloc<GetTodosEvent, GetTodosState> {
  final GetTodos getTodosUseCase;

  GetTodosBloc({required this.getTodosUseCase}) : super(GetTodosInitial()) {
    on<FetchTodos>((event, emit) async {
      emit(GetTodosLoading());
      final failureOrTodos = await getTodosUseCase(NoParams());
      failureOrTodos.fold(
        (failure) =>
            emit(GetTodosFailure(message: _mapFailureToMessage(failure))),
        (todos) => emit(GetTodosLoaded(todos: todos)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    return "failure";
  }
}
