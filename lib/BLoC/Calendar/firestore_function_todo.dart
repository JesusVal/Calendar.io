import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreConections {
  CollectionReference _firestore;
  var _firebaseUser;

  FirestoreConections(BuildContext context) {
    var user = context.watch<User>();
    this._firebaseUser = user.email;
    this._firestore = FirebaseFirestore.instance.collection(this._firebaseUser);
  }

  void addTodoTask(title, description) {
    var uid = Uuid();
    var uuid = uid.v4();
    this
        ._firestore
        .doc(uuid)
        .set({
          'uuid': uuid,
          'title': title,
          'description': description,
          'status': false,
        })
        .then((value) => print('Task added'))
        .catchError((e) {
          print("Something went wrong in adding task: $e");
        });
  }

  void changeTaskStatus(uuid, status) {
    this
        ._firestore
        .doc(uuid)
        .update({'status': (!status)})
        .then((value) => print('Document updated'))
        .catchError((e) => print('somethin failed in update: $e'));
  }

  void deleteTask(uuid) {
    this
        ._firestore
        .doc(uuid)
        .delete()
        .then((value) => print('Succefully deleted'))
        .catchError((e) => print('somethin failed in delete: $e'));
  }

  Future getAllTasks() async {
    return this._firestore.get();
  }

  Future getAllTasksByStatus(status) async {
    return this._firestore.where('status', isEqualTo: status).get();
  }
}
