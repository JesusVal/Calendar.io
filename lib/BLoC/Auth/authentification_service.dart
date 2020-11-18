import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> singOutFirebase() async {
    await _firebaseAuth.signOut();
  }

  Future<String> loginFirebase({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Logged";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> registerFirebase({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Created";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
