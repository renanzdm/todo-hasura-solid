import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterando_todo_list/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterando_todo_list/app/modules/home/home_page.dart';
import 'package:flutterando_todo_list/app/modules/repositories/todo_firebase_repository.dart';
import 'package:flutterando_todo_list/app/modules/repositories/todo_hasura_repository.dart';
import 'package:flutterando_todo_list/app/modules/repositories/todo_repository_interface.dart';
import 'package:hasura_connect/hasura_connect.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i.get())),
        Bind<ITodoRepository>(
            (i) => TodoFirebaseRepository(Firestore.instance)),
        //Bind<ITodoRepository>((i) => TodoHasuraRepository()),
        //Bind((i)=> HasuraConnect())
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
