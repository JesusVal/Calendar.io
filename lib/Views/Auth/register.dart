import 'package:Calendar_io/BLoC/Auth/form_bloc.dart';
import 'package:Calendar_io/BLoC/Auth/form_provider.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                    'Register',
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
                                keyboardType: TextInputType.text,
                                maxLength: 20,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  errorText: snapshot.error,
                                ),
                                onChanged: formBloc.changePassword,
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]))),
                          child: StreamBuilder<String>(
                            stream: formBloc.email,
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              return TextField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "e@mail.com",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  errorText: snapshot.error,
                                ),
                                onChanged: formBloc.changeEmail,
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: StreamBuilder<String>(
                            stream: formBloc.password,
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              return TextField(
                                keyboardType: TextInputType.text,
                                maxLength: 20,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  errorText: snapshot.error,
                                ),
                                onChanged: formBloc.changePassword,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                    child: Center(
                        child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),
                    )),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      //TODO: resolve register
                      Navigator.pushNamed(context, '/login');
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
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Center(
                        child: Text(
                      "Already have an account",
                      style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),
                    )),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
