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

  void addEventCalendar(year, month, day, description, time) {
    var uid = Uuid();
    var uuid = uid.v4();
    this
        ._firestore
        .doc(uuid)
        .set({
          'uuid': uuid,
          'day': day,
          'month': month,
          'year': year,
          'description': description,
          'time': time,
        })
        .then((value) => print('added'))
        .catchError((e) {
          print("Something went wrong in add: $e");
        });
  }

  void updateEventCalendar(uuid, year, month, day, description, time) {
    this
        ._firestore
        .doc(uuid)
        .update({
          'day': day,
          'month': month,
          'year': year,
          'description': description,
          'time': time,
        })
        .then((value) => print('Document updated'))
        .catchError((e) => print('somethin failed in update: $e'));
  }

  void deleteEventCalendar(uuid) {
    this
        ._firestore
        .doc(uuid)
        .delete()
        .then((value) => print('Succefully deleted'))
        .catchError((e) => print('somethin failed in delete: $e'));
  }

  Future getEventPerDate(year, month, day) async {
    print(year);
    print(month);
    print(day);
    return this
        ._firestore
        .where('year', isEqualTo: year.toString())
        .where('month', isEqualTo: month.toString())
        .where('day', isEqualTo: day.toString())
        .get();
  }

  void printTest() {
    this
        ._firestore
        // .doc(this._firebaseUser)
        // .where(this._firebaseUser,arrayContains: {'description': "13", 'time': "t3"})
        .where("time", isEqualTo: "t36")
        .get()
        .then((elem) {
      print(elem.docs);
    }
            //  elem.docs.forEach((element) {print(element.data());})
            ).catchError((e) => print('somethin failed: $e'));
    print('printing');
  }
}
