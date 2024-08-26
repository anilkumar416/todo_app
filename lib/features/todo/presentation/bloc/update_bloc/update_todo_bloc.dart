import 'package:bloc/bloc.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/todo/domain/usecases/update_todo.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

part 'update_todo_event.dart';
part 'update_todo_state.dart';

class UpdateTodoBloc extends Bloc<UpdateTodoEvent, UpdateTodoState> {
  final UpdateTodo updateTodoUseCase;

  UpdateTodoBloc({required this.updateTodoUseCase})
      : super(UpdateTodoInitial()) {
    on<UpdateTodoButtonPressed>((event, emit) async {
      emit(UpdateTodoLoading());
      final failureOrSuccess = await updateTodoUseCase(event.todo);
      failureOrSuccess.fold(
        (failure) =>
            emit(UpdateTodoFailure(message: _mapFailureToMessage(failure))),
        (_) => emit(UpdateTodoSuccess(updatedTodo: event.todo)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    return "failure";
  }
}
