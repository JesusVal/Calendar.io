import 'package:Calendar_io/BLoC/Auth/form_bloc.dart';
import 'package:Calendar_io/BLoC/Auth/form_provider.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = FormProvider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 350,
                child: Text("Calendario"),
              ),
              SizedBox(height: 10),
              Container(
                height: 350,
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
