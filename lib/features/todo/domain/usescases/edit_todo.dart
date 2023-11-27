import 'package:organize_me/core/usecases/usecase.dart';
import 'package:organize_me/features/todo/domain/repository/todo_repository.dart';
import 'package:organize_me/features/todo/domain/entities/todo.dart';

class EditToDOUseCase implements Usecase<TodoEntity, TodoEntity> {
  final TodoRepository _todoRepository;
  EditToDOUseCase(this._todoRepository);
  @override
  Future<TodoEntity> call({TodoEntity ? params}) async {
    return await _todoRepository.editToDO(params!);
  }
}
