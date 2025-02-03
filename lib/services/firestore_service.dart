

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoist/models/task.dart';

class FirestoreService {
  final CollectionReference _tasksCollection = FirebaseFirestore.instance.collection('tasks');
  //Fetch tasks
  Stream<List<Tasks>> getTasks() {
    return _tasksCollection.snapshots().map(
      (snapshot){
        return snapshot.docs.map((doc){
          return Tasks.fromMap(doc.data() as Map<String, dynamic>,doc.id);
        }).toList();
      }
    );
  }
  //Add tasks
  Future<void> addTask(Tasks task) async {
    await _tasksCollection.add(task.toMap());
  }
  //Update tasks
  Future<void> updateTask(String id,bool isDone)async{
    await _tasksCollection.doc(id).update({"isDone":isDone});
  }

  //Delete tasks 
  Future<void> deleteTask(String id) async {
    await _tasksCollection.doc(id).delete();
  }


}