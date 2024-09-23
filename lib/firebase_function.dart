import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c11_flutter/model/task_model.dart';
import 'package:todo_c11_flutter/model/useModelr.dart';

class FirebaseFunction {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance.collection("Tasks").withConverter(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (taskModel, _) {
        return taskModel.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }

  static Future<void> addUser(UserModel userModel) {
    var collection = getUsersCollection();
    var docRef = collection.doc(userModel.id);
    return docRef.set(userModel);
  }

  static Future<UserModel?> readUser(String id) async {
    DocumentSnapshot<UserModel> docRef =
        await getUsersCollection().doc(id).get();

    return docRef.data();
  }

  static Future<void> addTask(TaskModel model) async {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    model.id = docRef.id;
    docRef.set(model);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime dateTime) {
    var collection = getTasksCollection();
    return collection
        .where("userId",
            isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? "")
        .where('date',
            isEqualTo: DateUtils.dateOnly(dateTime).microsecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel model) {
    return getTasksCollection().doc(model.id).update(model.toJson());
  }

  static createAccountAuth(String emailAddress, String password,
      {required Function onSeccess,
      required Function onError,
      required int age,
      required String userName,
      required String phone}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      credential.user?.sendEmailVerification();
      UserModel userModel = UserModel(
          email: emailAddress, userName: userName, age: age, phone: phone);
      addUser(userModel);
      onSeccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    } catch (e) {
      onError(e.toString());
    }
  }

  static loginUser(String email, String password,
      {required Function onSeccess, required Function onError}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      onSeccess(credential.user?.displayName ?? " ");
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    } catch (e) {
      onError(e.toString());
    }
  }
}
