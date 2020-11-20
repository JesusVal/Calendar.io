import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarListEvents extends StatefulWidget {
  Future _dataPassed;

  CalendarListEvents(Future dataPassed) {
    this._dataPassed = dataPassed;
  }

  @override
  _CalendarListEventsState createState() =>
      _CalendarListEventsState(_dataPassed);
}

class _CalendarListEventsState extends State<CalendarListEvents> {
  Future _dataPassed;

  _CalendarListEventsState(Future dataPassed) {
    this._dataPassed = dataPassed;
  }

  /*Future getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("kzkz98@outlook.com").get();
    return qn.docs;
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _dataPassed,
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
                itemCount: snapshot.data.docs.length + 1,
                itemBuilder: (_, index) {
                  if (index == 0) {
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text('Today',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    );
                  }
                  index -= 1;

                  return Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.check_mark_circled_solid,
                          color: Colors.red,
                          size: 30,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data.docs[index].get('time'),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Text(
                                snapshot.data.docs[index].get('description'),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("No events found."),
              );
            }
          }
        },
      ),
    );
  }
}
