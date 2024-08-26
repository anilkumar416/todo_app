import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/presentation/bloc/delete_bloc/delete_todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/get_bloc/get_todos_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/update_bloc/update_todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/widgets/add_todo_dialog.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_list.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  TodoPageState createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteTodoBloc, DeleteTodoState>(
          listener: (context, state) {
            if (state is DeleteTodoSuccess) {
              context.read<GetTodosBloc>().add(FetchTodos());
            } else if (state is DeleteTodoFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
        BlocListener<UpdateTodoBloc, UpdateTodoState>(
          listener: (context, state) {
            if (state is UpdateTodoSuccess) {
              //Refetch of todos after a successful update
              context.read<GetTodosBloc>().add(FetchTodos());
            } else if (state is UpdateTodoFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todos'),
          actions: [
            DropdownButton<String>(
              value: _selectedFilter,
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All')),
                DropdownMenuItem(value: 'Completed', child: Text('Completed')),
                DropdownMenuItem(value: 'Pending', child: Text('Pending')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
              },
            ),
          ],
        ),
        body: BlocBuilder<GetTodosBloc, GetTodosState>(
          builder: (context, state) {
            if (state is GetTodosLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetTodosLoaded) {
              final todos = _filterTodos(state.todos, _selectedFilter);
              if (todos.isEmpty) {
                return const Center(
                  child: Text('No Todos'),
                );
              }
              return TodoList(todos: todos);
            } else if (state is GetTodosFailure) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Press the + button to add a Todo'),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AddTodoDialog(),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  List<Todo> _filterTodos(List<Todo> todos, String filter) {
    if (filter == 'Completed') {
      return todos.where((todo) => todo.isCompleted).toList();
    } else if (filter == 'Pending') {
      return todos.where((todo) => !todo.isCompleted).toList();
    }
    return todos;
  }
}
