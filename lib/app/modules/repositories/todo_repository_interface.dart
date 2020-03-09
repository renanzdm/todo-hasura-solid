import 'package:flutterando_todo_list/app/modules/models/todo_model.dart';

abstract class ITodoRepository {
  Stream<List<TodoModel>> getTodo();
  Future save(TodoModel model);

  Future delete(TodoModel model);
}
