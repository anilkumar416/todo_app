part of 'add_todo_bloc.dart';

abstract class AddTodoState {}

class AddTodoInitial extends AddTodoState {}

class AddTodoLoading extends AddTodoState {}

class AddTodoSuccess extends AddTodoState {}

class AddTodoFailure extends AddTodoState {
  final String message;
  AddTodoFailure({required this.message});
}
