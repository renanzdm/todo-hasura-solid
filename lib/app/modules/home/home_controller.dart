import 'package:flutterando_todo_list/app/modules/models/todo_model.dart';
import 'package:flutterando_todo_list/app/modules/repositories/todo_repository_interface.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final ITodoRepository iTodoRepository;
  @observable
  ObservableStream<List<TodoModel>> todoList;

  _HomeControllerBase(ITodoRepository this.iTodoRepository) {
    getTodoList();
  }

  @action
  getTodoList() {
    todoList = iTodoRepository.getTodo().asObservable();
  }
}
