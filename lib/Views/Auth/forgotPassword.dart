import 'package:Calendar_io/BLoC/Auth/form_bloc.dart';
import 'package:Calendar_io/BLoC/Auth/form_provider.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = FormProvider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 350,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill,
                    )),
                  )),
                  //aditional background images
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: Color.fromRGBO(49, 39, 79, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(196, 135, 198, 1),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      )
                    ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]))),
                          child: StreamBuilder<String>(
                            stream: formBloc.password,
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              return TextField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "e@mail.com",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  errorText: snapshot.error,
                                ),
                                onChanged: formBloc.changePassword,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Center(
                        child: Text(
                      "I have the password",
                      style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),
                    )),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      //TODO: send a mail
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromRGBO(49, 39, 79, 1),
                      ),
                      child: Center(
                        child: Text(
                          "Recover password",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Center(
                        child: Text(
                      "Create Account",
                      style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),
                    )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
