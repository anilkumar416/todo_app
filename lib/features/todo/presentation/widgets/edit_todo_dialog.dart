import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/presentation/bloc/get_bloc/get_todos_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/update_bloc/update_todo_bloc.dart';

class EditTodoDialog extends StatefulWidget {
  final Todo todo;

  const EditTodoDialog({super.key, required this.todo});

  @override
  EditTodoDialogState createState() => EditTodoDialogState();
}

class EditTodoDialogState extends State<EditTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _title;

  @override
  void initState() {
    super.initState();
    _title = widget.todo.title;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateTodoBloc, UpdateTodoState>(
      listener: (context, state) {
        if (state is UpdateTodoSuccess) {
          context.read<GetTodosBloc>().add(FetchTodos());
          Navigator.of(context).pop();
        } else if (state is UpdateTodoFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: AlertDialog(
        title: const Text('Edit Todo'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            initialValue: _title,
            decoration: const InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
            onSaved: (value) {
              _title = value ?? '';
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                final updatedTodo = widget.todo.copyWith(title: _title);
                context
                    .read<UpdateTodoBloc>()
                    .add(UpdateTodoButtonPressed(todo: updatedTodo));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
