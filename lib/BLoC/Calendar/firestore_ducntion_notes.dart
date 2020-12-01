import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreConectionsNotes {
  CollectionReference _firestore;
  var _firebaseUser;

  FirestoreConectionsNotes(BuildContext context) {
    var user = context.watch<User>();
    this._firebaseUser = user.email;
    this._firestore = FirebaseFirestore.instance.collection(this._firebaseUser);
  }

  void addTodoTask(description) {
    var uid = Uuid();
    var uuid = uid.v4();
    this
        ._firestore
        .doc(uuid)
        .set({
          'uuid': uuid,
          'type': 'note',
          'note': description,
        })
        .then((value) => print('Note added'))
        .catchError((e) {
          print("Something went wrong in adding note: $e");
        });
  }

  void updateTask(uuid, note) {
    this
        ._firestore
        .doc(uuid)
        .update({'note': note})
        .then((value) => print("Task text updated"))
        .catchError((e) => print("Something failed in updated $e"));
  }

  void deleteNote(uuid) {
    this
        ._firestore
        .doc(uuid)
        .delete()
        .then((value) => print('Succefully deleted'))
        .catchError((e) => print('something failed in delete: $e'));
  }

  Future getAllNotes() async {
    return this._firestore.where('type', isEqualTo: 'note').get();
  }
}
