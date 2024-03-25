import 'package:chat_app/common/services/authentication/auth_service.dart';
import 'package:chat_app/common/services/chat/chat_service.dart';
import 'package:chat_app/common/widgets/k_drawer.dart';
import 'package:chat_app/common/widgets/k_user_tile.dart';
import 'package:chat_app/features/chat/view/chat_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

//chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const KDrawer(),
      body: _buildUsersList(),
    );
  }

//build a list of users except for current logged in user
  Widget _buildUsersList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        //if error show error
        if (snapshot.hasError) {
          return const Text('Error');
        }
        //if loading show loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        //return listview
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  //build individual tile list for user
  Widget _buildUserListItem(
      Map<String, dynamic>? userData, BuildContext context) {
    // Check if userData is null
    if (userData != null) {
      // Get current user email
      final currentUserEmail = _authService.getCurrentUser()?.email;

      // Check if currentUserEmail is null or empty
      if (currentUserEmail != null && userData['email'] != currentUserEmail) {
        return UserTile(
          text: userData['email'],
          onTap: () {
            // Navigate to chat page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData['email'],
                  receiverId: userData['uid'],
                ),
              ),
            );
          },
        );
      }
    }
    return Container(); // Return an empty container if userData is null or if it's the current user's data
  }
}
