import 'package:get_it/get_it.dart';
import 'package:organize_me/features/todo/data/data_source/local/DAO/app_database.dart';
import 'package:organize_me/features/todo/data/repository/todo_repository_impl.dart';
import 'package:organize_me/features/todo/domain/repository/todo_repository.dart';
import 'package:organize_me/features/todo/domain/usescases/get_todo.dart';
import 'package:organize_me/features/todo/presentation/bloc/local_todo_bloc.dart';

final sl = GetIt.instance;
Future<void> initDependencies() async {
  final database =
      await $FloorAppdatabase.databaseBuilder('app_database').build();
  sl.registerSingleton<Appdatabase>(database);
  
  sl.registerSingleton<TodoRepository>(TodoRepositoryImpl(sl()));

  sl.registerSingleton<GetToDoUsecase>(GetToDoUsecase(sl()));

  sl.registerFactory<LocalTodoBloc>(() => LocalTodoBloc(sl(), sl(), sl()));
}
