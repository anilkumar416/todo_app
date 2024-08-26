part of 'add_todo_bloc.dart';

abstract class AddTodoEvent {}

class AddTodoButtonPressed extends AddTodoEvent {
  final Todo todo;
  AddTodoButtonPressed({required this.todo});
}
