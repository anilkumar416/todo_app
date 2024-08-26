part of 'update_todo_bloc.dart';

abstract class UpdateTodoEvent {}

class UpdateTodoButtonPressed extends UpdateTodoEvent {
  final Todo todo;
  UpdateTodoButtonPressed({required this.todo});
}
