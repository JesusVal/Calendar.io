import 'package:Calendar_io/Views/Calendar/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotesList extends StatefulWidget {
  NotesList({Key key}) : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  TextEditingController _notesTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(),
      backgroundColor: Colors.deepPurple,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 400,
            child: Stack(
              children: <Widget>[
                // Positioned(
                //     child: Container(
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //     image: AssetImage('assets/images/background.png'),
                //     fit: BoxFit.fill,
                //   )),
                // )),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              'Notes',
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
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            "Note no $index",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          trailing: Icon(
                            CupertinoIcons.check_mark_circled_solid,
                            color: Colors.green,
                            size: 30,
                          ),
                        );
                      },
                    ),
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
                              // TODO: add notes
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
              "Add Note",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            TextField(
              controller: _notesTextController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.text_fields,
                  color: Colors.black,
                ),
                labelText: "Tell me",
                labelStyle: TextStyle(color: Colors.black87),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            MaterialButton(
              child: Text("Save"),
              onPressed: () {
                Navigator.of(context).pop();
                _notesTextController.clear();
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
}
