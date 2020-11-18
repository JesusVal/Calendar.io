import 'package:Calendar_io/BLoC/Auth/form_bloc.dart';
import 'package:Calendar_io/BLoC/Auth/form_provider.dart';
import 'package:Calendar_io/Views/Calendar/side_menu.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = FormProvider.of(context);

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text('Side menu'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 100),
              Container(
                height: 350,
                child: Text("Calendario"),
              ),
              SizedBox(height: 10),
              Container(
                height: 100,
                child: RaisedButton(
                  onPressed: () {
                    formBloc.singOut(context);
                  },
                  child: Text("Sign out"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
