import 'package:organize_me/core/usecases/usecase.dart';
import 'package:organize_me/features/todo/domain/repository/todo_repository.dart';
import 'package:organize_me/features/todo/domain/entities/todo.dart';

class AddTodDoUsecase implements Usecase<void, TodoEntity> {
  final TodoRepository _todoRepository;
  AddTodDoUsecase(this._todoRepository);
  @override
  Future<void> call({TodoEntity  ? params}) async {
    return await _todoRepository.addToDo(params!);
  }
}
