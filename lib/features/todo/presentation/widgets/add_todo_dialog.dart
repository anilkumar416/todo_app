import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/presentation/bloc/add_bloc/add_todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/get_bloc/get_todos_bloc.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  AddTodoDialogState createState() => AddTodoDialogState();
}

class AddTodoDialogState extends State<AddTodoDialog> {
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTodoBloc, AddTodoState>(
      listener: (context, state) {
        if (state is AddTodoSuccess) {
          context.read<GetTodosBloc>().add(FetchTodos());
          Navigator.of(context).pop();
        } else if (state is AddTodoFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: _titleController,
          decoration: const InputDecoration(labelText: 'Title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final title = _titleController.text.trim();
              if (title.isNotEmpty) {
                final newTodo = Todo(
                  id: DateTime.now().toString(),
                  title: title,
                  isCompleted: false,
                );
                context
                    .read<AddTodoBloc>()
                    .add(AddTodoButtonPressed(todo: newTodo));
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
