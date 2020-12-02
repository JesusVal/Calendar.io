import 'package:Calendar_io/BLoC/Auth/form_bloc.dart';
import 'package:Calendar_io/BLoC/Auth/form_provider.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = FormProvider.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Calendar.io',
                style: TextStyle(color: Colors.white, fontSize: 25)),
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/bluewindow.png'))),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Calendar'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/Calendar');
            },
          ),
          ListTile(
            leading: Icon(Icons.check_box_outlined),
            title: Text('To do'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/ToDo');
            },
          ),
          ListTile(
            leading: Icon(Icons.sticky_note_2_outlined),
            title: Text('Notes'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/Notes');
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              formBloc.singOut(context);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
