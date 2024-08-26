part of 'delete_todo_bloc.dart';

abstract class DeleteTodoState {}

class DeleteTodoInitial extends DeleteTodoState {}

class DeleteTodoLoading extends DeleteTodoState {}

class DeleteTodoSuccess extends DeleteTodoState {}

class DeleteTodoFailure extends DeleteTodoState {
  final String message;
  DeleteTodoFailure({required this.message});
}
