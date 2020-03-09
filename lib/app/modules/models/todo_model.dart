import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String title;
  bool check;
  DocumentReference reference;
  int id;
  TodoModel({this.reference, this.title = '', this.check = false, this.id});

  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    return TodoModel(
        title: doc['title'], check: doc['check'], reference: doc.reference);
  }
  factory TodoModel.fromJson(Map doc) {
    return TodoModel(title: doc['title'], check: doc['check'], id: doc['id']);
  }

  Future save() async {
    if (reference == null) {
      int total = (await Firestore.instance.collection('todo').getDocuments())
          .documents
          .length;
      reference = await Firestore.instance
          .collection('todo')
          .add({'title': title, 'check': check, 'position': total});
    } else {
      reference.updateData({'title': title, 'check': check});
    }
  }

  Future delete() {
    return reference.delete();
  }
}
