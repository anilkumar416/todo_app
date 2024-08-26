part of 'delete_todo_bloc.dart';

abstract class DeleteTodoEvent {}

class DeleteTodoButtonPressed extends DeleteTodoEvent {
  final String todoId;
  DeleteTodoButtonPressed({required this.todoId});
}
