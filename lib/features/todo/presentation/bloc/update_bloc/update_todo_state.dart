part of 'update_todo_bloc.dart';

abstract class UpdateTodoState {}

class UpdateTodoInitial extends UpdateTodoState {}

class UpdateTodoLoading extends UpdateTodoState {}

class UpdateTodoSuccess extends UpdateTodoState {
  final Todo updatedTodo;
  UpdateTodoSuccess({required this.updatedTodo});
}

class UpdateTodoFailure extends UpdateTodoState {
  final String message;
  UpdateTodoFailure({required this.message});
}
