import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled8/database/user.dart';

class UserDao {
  static CollectionReference<UserApp> getUsersCollection() {
    //create collection with name users
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter<UserApp>(
            fromFirestore: (snapshot, options) =>
                UserApp.fromFireStore(snapshot.data()),
            toFirestore: (userapp, options) => userapp.toFireStore());
  }

  static Future<void> addUser(UserApp userapp) {
    var usersCollections = getUsersCollection();
    var doc = usersCollections.doc(userapp.id);
    return doc.set(userapp);
  }

  static Future<UserApp?> getUserApp(String uid) async {
    var userAppCollection = getUsersCollection();
    var doc = userAppCollection.doc(uid);
    var docSnapshot = await doc.get();
    return docSnapshot.data();
  }
}
