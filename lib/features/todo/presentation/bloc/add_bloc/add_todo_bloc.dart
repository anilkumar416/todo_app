import 'package:bloc/bloc.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/todo/domain/usecases/add_todo.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  final AddTodo addTodoUseCase;

  AddTodoBloc({required this.addTodoUseCase}) : super(AddTodoInitial()) {
    on<AddTodoButtonPressed>((event, emit) async {
      emit(
        AddTodoLoading(),
      );
      final failureOrSuccess = await addTodoUseCase(event.todo);
      failureOrSuccess.fold(
        (failure) => emit(
          AddTodoFailure(
            message: _mapFailureToMessage(failure),
          ),
        ),
        (_) => emit(AddTodoSuccess()),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    return "failure";
  }
}
