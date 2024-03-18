import 'package:chat_app/common/authentication/home/homepage.dart';
import 'package:chat_app/features/login/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //user is logged in
            if (snapshot.hasData) {
              return const HomePage();
            }
            //user is not logged in
            else {
              return LoginPage();
            }
          }),
    );
  }
}
