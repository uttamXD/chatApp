import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async {
    _auth.signOut();
  }
  //error
}
