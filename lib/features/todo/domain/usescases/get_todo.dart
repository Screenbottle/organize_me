import 'package:organize_me/core/usecases/usecase.dart';
import 'package:organize_me/features/todo/domain/entities/todo.dart';
import 'package:organize_me/features/todo/domain/repository/todo_repository.dart';

class GetToDoUsecase implements Usecase<List<TodoEntity>, void> {
  final TodoRepository _todoRepository;
  GetToDoUsecase(this._todoRepository);
  @override
  Future<List<TodoEntity>> call({void params}) {
    return _todoRepository.getToDos();
  }
}
