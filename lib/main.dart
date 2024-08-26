import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/add_bloc/add_todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/delete_bloc/delete_todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/get_bloc/get_todos_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/update_bloc/update_todo_bloc.dart';
import 'features/todo/presentation/pages/todo_page.dart';
import 'core/di/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetTodosBloc>(
          create: (_) => di.sl<GetTodosBloc>()..add(FetchTodos()),
        ),
        BlocProvider<AddTodoBloc>(
          create: (_) => di.sl<AddTodoBloc>(),
        ),
        BlocProvider<UpdateTodoBloc>(
          create: (_) => di.sl<UpdateTodoBloc>(),
        ),
        BlocProvider<DeleteTodoBloc>(
          create: (_) => di.sl<DeleteTodoBloc>(),
        ),
      ],
      child: const MaterialApp(
        home: TodoPage(),
      ),
    );
  }
}
