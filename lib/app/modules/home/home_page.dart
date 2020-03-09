import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterando_todo_list/app/modules/models/todo_model.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showDialog,
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(
        builder: (_) {
          if (controller.todoList.hasError) {
            return Center(
              child: RaisedButton(
                  color: Colors.red.shade500,
                  child: Text('ERRO'),
                  onPressed: () {
                    controller.getTodoList();
                  }),
            );
          }

          if (controller.todoList.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<TodoModel> listTodo = controller.todoList.data;
          return ListView.builder(
            itemCount: listTodo.length,
            itemBuilder: (_, index) {
              return ListTile(
                onTap: () {
                  _showDialog(listTodo[index]);
                },
                title: Text(
                  listTodo[index].title,
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.restore_from_trash,
                    color: Colors.red,
                  ),
                  onPressed: listTodo[index].delete,
                ),
                trailing: Checkbox(
                    value: listTodo[index].check,
                    onChanged: (value) {
                      listTodo[index].check = value;
                      listTodo[index].save();
                    }),
              );
            },
          );
        },
      ),
    );
  }

  _showDialog([TodoModel model]) {
    model ??= TodoModel();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(model.title == '' ? 'Adicionar Novo' : 'Editar'),
          content: TextFormField(
            initialValue: model.title,
            onChanged: (value) => model.title = value,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Digite'),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () async {
                  await model.save();
                  Modular.to.pop();
                },
                child: Text('Adicionar')),
            FlatButton(
                color: Colors.red,
                onPressed: () {
                  Modular.to.pop();
                },
                child: Text('Cancelar')),
          ],
        );
      },
    );
  }
}
