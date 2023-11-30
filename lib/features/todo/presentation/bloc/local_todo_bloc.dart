import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organize_me/features/todo/domain/entities/todo.dart';
import 'package:organize_me/features/todo/domain/usescases/add_todo.dart';
import 'package:organize_me/features/todo/domain/usescases/delete_todo.dart';
import 'package:organize_me/features/todo/domain/usescases/get_todo.dart';
import 'package:organize_me/features/todo/presentation/bloc/local_todo_event.dart';
import 'package:organize_me/features/todo/presentation/bloc/local_todo_state.dart';

class LocalTodoBloc extends Bloc<LocalTodoEvent, LocalTodoState> {
  final GetToDoUsecase _getSavedTodoUseCase;
  final AddTodDoUsecase _addTodoUseCase;
  final DeleteToDoUseCase _deleteTodoUseCase;

  LocalTodoBloc(
      this._getSavedTodoUseCase, this._addTodoUseCase, this._deleteTodoUseCase)
      : super(const LocaltodoLoading()) {
    on<GetTodo>(onGetTodo);
    on<RemoveTodo>(ondDeleteTodo);
    on<SaveTodo>(onAddTodo);
  }

  void onGetTodo(GetTodo event, Emitter<LocalTodoState> emit) async {
    final todos = await _getSavedTodoUseCase();
    emit(LocaltodoDone(todos));
  }

  void ondDeleteTodo(
      RemoveTodo removeTodo, Emitter<LocalTodoState> emit) async {
    await _deleteTodoUseCase(params: removeTodo.todo);
    final todos = await _getSavedTodoUseCase;
    emit(LocaltodoDone(todos as List<TodoEntity>));
  }

  void onAddTodo(SaveTodo saveTodo, Emitter<LocalTodoState> emit) async {
    await _addTodoUseCase(params: saveTodo.todo);
    final todos = await _getSavedTodoUseCase;
    emit(LocaltodoDone(todos as List<TodoEntity>));
  }
}
