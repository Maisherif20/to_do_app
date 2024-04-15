import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../database/user.dart';
import '../database/userDao.dart';

class MyAuthProvider extends ChangeNotifier {
  UserApp? databaseUserApp;
  User? firebaseAuthUser;

 Future<void> register(
      String fullName, String password, String userName, String email) async {
    var crediential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await UserDao.addUser(UserApp(
      id: crediential.user?.uid,
      fullNmae: fullName,
      userName: userName,
      email: email,
    ));
  }

  Future<void>login(String emailController, String passwordController) async {
    var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController, password: passwordController);
    databaseUserApp = await UserDao.getUserApp(credential.user!.uid);
    firebaseAuthUser = credential.user;
  }
}
