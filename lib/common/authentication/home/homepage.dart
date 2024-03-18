import 'package:chat_app/common/authentication/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    //suthService
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          //logout
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
