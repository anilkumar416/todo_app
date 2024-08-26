part of 'get_todos_bloc.dart';

abstract class GetTodosState {}

class GetTodosInitial extends GetTodosState {}

class GetTodosLoading extends GetTodosState {}

class GetTodosLoaded extends GetTodosState {
  final List<Todo> todos;
  GetTodosLoaded({required this.todos});
}

class GetTodosFailure extends GetTodosState {
  final String message;
  GetTodosFailure({required this.message});
}
