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
          title: const Center(child: Text('Home')),
        ),
        drawer: const KDrawer(),
        body: _buildUsersList());
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
      Map<String, dynamic> userData, BuildContext context) {
//display all user except current user
    if (userData['email'] != _authService.getCurrentuser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          //on tap navigate to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData['email'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
