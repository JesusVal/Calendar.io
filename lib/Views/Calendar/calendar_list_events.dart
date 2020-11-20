import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarListEvents extends StatefulWidget {
  CalendarListEvents({Key key}) : super(key: key);

  @override
  _CalendarListEventsState createState() => _CalendarListEventsState();
}

class _CalendarListEventsState extends State<CalendarListEvents> {
  Future getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("kzkz98@outlook.com").get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(
                'Loading',
                style: TextStyle(color: Colors.black),
              ),
            );
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return Container(
                    height: 30,
                    child: Text(
                      snapshot.data[index].get('time'),
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("No users found."),
              );
            }
          }
        },
      ),
    );
  }
}
