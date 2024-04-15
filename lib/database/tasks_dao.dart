import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled8/database/task.dart';
import 'package:untitled8/database/userDao.dart';

class TaskDao {
  static CollectionReference<Task> getTaskCollection(String uid) {
    return UserDao.getUsersCollection()
        .doc(uid)
        .collection(Task.taskCollectionName)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Task.fromFireSore(snapshot.data()),
            toFirestore: (task, options) => task.toFireSore());
  }

  static Future<List<Task>> getAllTasks(String uid) async {
    var tasksCollection = getTaskCollection(uid);
    var snapShot = await tasksCollection.get();
    return snapShot.docs.map((e) => e.data()).toList();
  }

  static Future<void> addTask(Task task, String uid) {
    var tasksCollection = getTaskCollection(uid);
    var docTaskCollection = tasksCollection.doc();

    task.id = docTaskCollection
        .id; // makeing id of user document same to id of task document

    return docTaskCollection.set(task); //set tasks in database
  }

  static Stream<List<Task>> listenForNewTask(String uid, DateTime selectedDate) async* {
    var taskCollection = getTaskCollection(uid);
    var streams =
         taskCollection.where('datetime', isEqualTo: selectedDate).snapshots();
    yield* streams.map(
        (QuerySnapShot) => QuerySnapShot.docs.map((e) => e.data()).toList());
  }

  static Future<void> deleteTask(String uid, String taskId) {
    var tasksCollection = getTaskCollection(uid);
    return tasksCollection.doc(taskId).delete();
  }

  static updateTask(String uid, String taskId, String title, String description,
      DateTime datetime) {
    var tasksCollection = getTaskCollection(uid);
    return tasksCollection.doc(taskId).update({
      'title': title,
      'description': description,
      'datetime': datetime,
    });
  }

  static update(String uid, String taskId , Task task) {
    var tasksCollection = getTaskCollection(uid);
    return tasksCollection.doc(taskId).update(task.toFireSore());
  }
}
