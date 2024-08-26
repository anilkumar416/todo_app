import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:todo_app/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart'; // Import the interface
import 'package:todo_app/features/todo/domain/usecases/add_todo.dart';
import 'package:todo_app/features/todo/domain/usecases/delete_todo.dart';
import 'package:todo_app/features/todo/domain/usecases/get_todos.dart';
import 'package:todo_app/features/todo/domain/usecases/update_todo.dart';
import 'package:todo_app/features/todo/presentation/bloc/add_bloc/add_todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/delete_bloc/delete_todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/get_bloc/get_todos_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/update_bloc/update_todo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // Data sources
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repositories
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTodos(sl()));
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));

  // Blocs
  sl.registerFactory(() => GetTodosBloc(getTodosUseCase: sl()));
  sl.registerFactory(() => AddTodoBloc(addTodoUseCase: sl()));
  sl.registerFactory(() => UpdateTodoBloc(updateTodoUseCase: sl()));
  sl.registerFactory(() => DeleteTodoBloc(deleteTodoUseCase: sl()));
}
