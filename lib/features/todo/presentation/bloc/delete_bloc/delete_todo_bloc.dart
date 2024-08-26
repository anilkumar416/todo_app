import 'package:bloc/bloc.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/todo/domain/usecases/delete_todo.dart';

part 'delete_todo_event.dart';
part 'delete_todo_state.dart';

class DeleteTodoBloc extends Bloc<DeleteTodoEvent, DeleteTodoState> {
  final DeleteTodo deleteTodoUseCase;

  DeleteTodoBloc({required this.deleteTodoUseCase})
      : super(DeleteTodoInitial()) {
    on<DeleteTodoButtonPressed>((event, emit) async {
      emit(DeleteTodoLoading());
      final failureOrSuccess = await deleteTodoUseCase(event.todoId);
      failureOrSuccess.fold(
        (failure) =>
            emit(DeleteTodoFailure(message: _mapFailureToMessage(failure))),
        (_) => emit(DeleteTodoSuccess()),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    return "failure";
  }
}
