import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_demo_app/models/todo.dart';

class TodoRepository {
  final db = FirebaseFirestore.instance;

  Future<void> addNewTodo(Todo data) async {
    final CollectionReference<Map<String, dynamic>> todoCollection = db.collection('todos');
    await todoCollection.add(data.toMap());
  }

  Future<List<Todo>> getAllTodos() async {
    final CollectionReference<Map<String, dynamic>> todoCollection = db.collection('todos');
    final QuerySnapshot<Map<String, dynamic>> response = await todoCollection.get();
    final result = response.docs.map((doc) => Todo.fromSnapshot(doc)).toList();
    return result;
  }
}
