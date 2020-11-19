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
    this._firestore = FirebaseFirestore.instance.collection('calendar');
  }

  void initDocument(description, time){
    this
        ._firestore
        .doc(this._firebaseUser)
        .set({
          "status": 'active'
        })
        .then((value) {
          print('document created');
          addEventCalendar(description, time, false);
        })
        .catchError((e) => print('somethin failed: $e'));
  }

  void addEventCalendar(description, time, [created = true]) {
    var uid = Uuid();
    var uuid = uid.v4();
    this
        ._firestore
        .doc(this._firebaseUser)
        .update({
          "$uuid": {'description': description, 'time': time}
        })
        .then((value) => print('added'))
        .catchError((e) {
          if(e.code == 'not-found' && created == true){
            print('im in');
            initDocument(description, time);
          }else{
            print("Something went wrong: $e");
          }
        });
  }

  void updateEventCalendar(description, time, uid) {
    this
        ._firestore
        .doc(this._firebaseUser)
        .update({
          "$uid": {'description': description, 'time': time}
        })
        .then((value) => print('added'))
        .catchError((e) => print('somethin failed: $e'));
  }

  void deleteEventCalendar(uid) {
    this
        ._firestore
        .doc(this._firebaseUser)
        .update({
          "$uid": FieldValue.delete()
        })
        .then((value) => print('added'))
        .catchError((e) => print('somethin failed: $e'));
  }
}
