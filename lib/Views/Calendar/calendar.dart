import 'package:Calendar_io/Views/Calendar/calendar_list_events.dart';
import 'package:Calendar_io/Views/Calendar/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:Calendar_io/BLoC/Calendar/firestore_fucntions.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;
  DateTime date = DateTime.now();
  Future<dynamic> getDataFunction;

  TextEditingController _todoTextController = TextEditingController();
  TimeOfDay _horario;
  DateTime _fecha;

  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _calendarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirestoreConections _conecction = FirestoreConections(context);
    Future<dynamic> getData(year, month, day) async {
      return _conecction.getEventPerDate(year, month, day);
    }

    if (getDataFunction == null) {
      getDataFunction = getData(date.year, date.month, date.day);
    }

/*
    Future getData() async {
      DateTime date = DateTime.now();
      return _conecction.getEventPerDate(date.year, date.month, date.day);
    }*/

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text('Side menu'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TableCalendar(
                calendarController: _calendarController,
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (day, events, holidays) {
                  print("year- " + day.year.toString());
                  print("month- " + day.month.toString());
                  print("day- " + day.day.toString());
                  setState(() {
                    getDataFunction = getData(day.year, day.month, day.day);
                  });
                },
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.only(left: 30),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: FutureBuilder(
                    future: Future.wait([
                      getDataFunction,
                    ]),
                    builder: (_, AsyncSnapshot<List<dynamic>> snapshot) {
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
                            itemCount: snapshot.data[0].docs.length + 1,
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

                              return Dismissible(
                                key: UniqueKey(),
                                background: Container(
                                  color: Colors.indigo,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        CupertinoIcons.check_mark_circled_solid,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data[0].docs[index]
                                                  .get('time'),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              snapshot.data[0].docs[index]
                                                  .get('description'),
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
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            builder: (context) => StatefulBuilder(
              // para refrescar la botton sheet en caso de ser necesario
              builder: (context, setModalState) =>
                  _bottomSheet(context, setModalState),
            ),
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
          ).then(
            (result) {
              if (result != null) {
                // DIDIT: bloc add evento to add reminder to db
                // DIDIT: add reminder to HomeBody list view
                // _homeBloc.add(OnAddElementEvent(todoReminder: result));
              }
            },
          );
        },
        label: Text("Agregar"),
        icon: Icon(Icons.add_circle),
      ),

      /*FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () => _conecction.printTest(),
        // db.addEventCalendar('13', 't36');
      ),*/
    );
  }

  Widget _bottomSheet(BuildContext context, StateSetter setModalState) {
    return Padding(
      padding: EdgeInsets.only(
        top: 24.0,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Agrega recordatorio",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            TextField(
              controller: _todoTextController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.text_fields,
                  color: Colors.black,
                ),
                labelText: "Ingrese actividad",
                labelStyle: TextStyle(color: Colors.black87),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.timer),
                  onPressed: () {
                    _selectTime(context);
                    // refreshes modal bottom sheet with new hour value
                    setModalState(() {});
                  },
                ),
                Text(
                  _horario == null
                      ? "Seleccione horario"
                      : "${_horario.hour}:${_horario.minute}",
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.timer),
                  onPressed: () {
                    _selectDateTime(context);
                    // refreshes modal bottom sheet with new hour value
                    setModalState(() {});
                  },
                ),
                Text(
                  _horario == null ? "Seleccione una fecha" : "not null",
                ),
              ],
            ),
            SizedBox(height: 12),
            MaterialButton(
              child: Text("Save"),
              onPressed: () {
                _todoTextController.clear();
                _horario = null;
              },
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (time) {
        if (time != null) {
          _horario = time;
        }
      },
    );
  }

  _selectDateTime(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((date) {
      if (date != null) {
        _fecha = date;
      }
    });
  }
}
