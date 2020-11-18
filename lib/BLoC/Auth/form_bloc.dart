import 'package:Calendar_io/BLoC/Auth/validator_mixin.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class FormBloc with ValidationMixin {
  final _email = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();

  // getters
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  // streams
  Stream<String> get email => _email.stream.transform(validatorEmail);
  Stream<String> get password => _password.stream.transform(validatorPassword);

  Stream<bool> get submitValidForm =>
      Rx.combineLatest2(email, password, (e, p) {
        print(email);
        print(password);
        if ((e == 'kzkz98@outlook.com') && (p == 'pass1234')) {
          return true;
        } else {
          return false;
        }
      });

  //Rx.combineLatest2(email, password, (e, p) => true);
  //LogIn
  bool submit() {
    print('Login');
    print(_email.value);
    print(_password.value);
    if ((_email.value == 'kzkz98@outlook.com') &&
        (_password.value == 'pass1234')) {
      return true;
    } else {
      return false;
    }
  }

  //SignIn
  createUser() {
    print('User created');
    print(_email.value);
    print(_password.value);
  }

  dispose() {
    _email.close();
    _password.close();
  }
}
