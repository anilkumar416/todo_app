import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/presentation/bloc/update_bloc/update_todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/delete_bloc/delete_todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/widgets/edit_todo_dialog.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;

  const TodoList({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoListItem(todo: todo);
      },
    );
  }
}

class TodoListItem extends StatelessWidget {
  final Todo todo;

  const TodoListItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(todo.id),
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => EditTodoDialog(todo: todo),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<DeleteTodoBloc>().add(
                    DeleteTodoButtonPressed(todoId: todo.id),
                  );
            },
          ),
        ],
      ),
      leading: BlocBuilder<UpdateTodoBloc, UpdateTodoState>(
        builder: (context, state) {
          return Checkbox(
            value: todo.isCompleted,
            onChanged: (bool? value) {
              final updatedTodo = todo.copyWith(isCompleted: value ?? false);
              context.read<UpdateTodoBloc>().add(
                    UpdateTodoButtonPressed(todo: updatedTodo),
                  );
            },
          );
        },
      ),
    );
  }
}
