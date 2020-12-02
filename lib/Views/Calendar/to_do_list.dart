import 'package:Calendar_io/BLoC/Calendar/firestore_function_todo.dart';
import 'package:Calendar_io/Views/Calendar/side_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  ToDoList({Key key}) : super(key: key);

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  TextEditingController _todoDescriptionTextController =
      TextEditingController();
  TextEditingController _todoTitleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirestoreConectionsTODO _conecction = FirestoreConectionsTODO(context);

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(),
      backgroundColor: Colors.deepPurple,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/galaxy.png'),
                    fit: BoxFit.fill,
                  )),
                )),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              'To Do List',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
          DraggableScrollableSheet(
            maxChildSize: 0.85,
            builder: (BuildContext context, ScrollController scrollController) {
              return Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: FutureBuilder(
                        future: _conecction.getAllTasks(),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Text(
                                'Loading',
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          } else {
                            if (snapshot.data != null) {
                              return ListView.builder(
                                controller: scrollController,
                                itemCount: snapshot.data.docs.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return Container(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 20, left: 20),
                                        child: Text('Tasks',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    );
                                  }
                                  index -= 1;

                                  return GestureDetector(
                                    onDoubleTap: () async {
                                      _todoTitleTextController.text = snapshot
                                          .data.docs[index]
                                          .get('title');
                                      _todoDescriptionTextController.text =
                                          snapshot.data.docs[index]
                                              .get('description');

                                      await showModalBottomSheet(
                                        context: context,
                                        builder: (context) => StatefulBuilder(
                                            // para refrescar la botton sheet en caso de ser necesario
                                            builder: (context, setModalState) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              top: 24.0,
                                              left: 24,
                                              right: 24,
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom,
                                            ),
                                            child: Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Update task",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 24,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _todoTitleTextController,
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                        Icons.text_fields,
                                                        color: Colors.black,
                                                      ),
                                                      labelText: "Title",
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                      border:
                                                          OutlineInputBorder(),
                                                      focusedBorder:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _todoDescriptionTextController,
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                        Icons.text_fields,
                                                        color: Colors.black,
                                                      ),
                                                      labelText: "Description",
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Colors.black87),
                                                      border:
                                                          OutlineInputBorder(),
                                                      focusedBorder:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  SizedBox(height: 12),
                                                  MaterialButton(
                                                    child: Text("Save"),
                                                    onPressed: () {
                                                      if (_todoTitleTextController
                                                                  .text !=
                                                              '' &&
                                                          _todoDescriptionTextController
                                                                  .text !=
                                                              '') {
                                                        _conecction.updateTask(
                                                            snapshot.data
                                                                .docs[index]
                                                                .get('uuid'),
                                                            _todoTitleTextController
                                                                .text,
                                                            _todoDescriptionTextController
                                                                .text);

                                                        _todoTitleTextController
                                                            .clear();
                                                        _todoDescriptionTextController
                                                            .clear();
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 24,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
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
                                    child: Dismissible(
                                      key: UniqueKey(),
                                      background: Container(
                                        color: Colors.indigo,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          snapshot.data.docs[index]
                                              .get('title'),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        subtitle: Text(
                                          snapshot.data.docs[index]
                                              .get('description'),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            CupertinoIcons.circle_fill,
                                            color: (snapshot.data.docs[index]
                                                    .get('status'))
                                                ? Colors.green
                                                : Colors.red,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _conecction.changeTaskStatus(
                                                  snapshot.data.docs[index]
                                                      .get('uuid'),
                                                  snapshot.data.docs[index]
                                                      .get('status'));
                                            });
                                          },
                                        ),
                                      ),
                                      onDismissed: (direction) {
                                        _conecction.deleteTask(snapshot
                                            .data.docs[index]
                                            .get('uuid'));
                                      },
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: Text("No events found.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    )),
                              );
                            }
                          }
                        }),
                  ),
                  Positioned(
                    top: -20,
                    right: 30,
                    child: FloatingActionButton(
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          builder: (context) => StatefulBuilder(
                              // para refrescar la botton sheet en caso de ser necesario
                              builder: (context, setModalState) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: 24.0,
                                left: 24,
                                right: 24,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Add task",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    TextField(
                                      controller: _todoTitleTextController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.text_fields,
                                          color: Colors.black,
                                        ),
                                        labelText: "Title",
                                        labelStyle:
                                            TextStyle(color: Colors.black87),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    TextField(
                                      controller:
                                          _todoDescriptionTextController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.text_fields,
                                          color: Colors.black,
                                        ),
                                        labelText: "Description",
                                        labelStyle:
                                            TextStyle(color: Colors.black87),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    MaterialButton(
                                      child: Text("Save"),
                                      onPressed: () {
                                        if (_todoTitleTextController.text !=
                                                '' &&
                                            _todoDescriptionTextController
                                                    .text !=
                                                '') {
                                          _conecction.addTodoTask(
                                              _todoTitleTextController.text,
                                              _todoDescriptionTextController
                                                  .text);

                                          _todoTitleTextController.clear();
                                          _todoDescriptionTextController
                                              .clear();
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
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
                      backgroundColor: Colors.pinkAccent,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
