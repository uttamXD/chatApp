import 'package:chat_app/common/services/authentication/auth_service.dart';
import 'package:chat_app/common/services/chat/chat_service.dart';
import 'package:chat_app/common/widgets/k_chat_bubble.dart';
import 'package:chat_app/common/widgets/k_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
//text controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

//for textfield focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    //add lsitener to focus node
    myFocusNode.addListener(
      () {
        if (myFocusNode.hasFocus) {
          //cause a delay so keyboard has time to show
          //then the amount of remaining space will be calculated
          //then scroll down
          Future.delayed(
            const Duration(milliseconds: 500),
            () => scrollDown(),
          );
        }
      },
    );

    //wait a bit for listview to build the scroll down
    Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

//scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  //send message
  void sendMessage() async {
//if there is something inside textfield
    if (_messageController.text.isNotEmpty) {
      //send message
      await _chatService.sendMessage(
          widget.receiverId, _messageController.text);
      //clear messageContreller
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          //display all message
          Expanded(
            child: _buildMessageList(),
          ),

          //user input
          _buildUserInput(),
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(widget.receiverId, senderId),
      builder: ((context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text('Error');
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        //return listview
        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      }),
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

//align message to the right if sender is current user otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
    );
  }

  //build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        children: [
          //textfield
          Expanded(
            child: KTextFormField(
              hintText: "Type a message",
              obscureText: false,
              controller: _messageController,
              focusNode: myFocusNode,
            ),
          ),

          //send button
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send),
              color: Colors.blue[900],
            ),
          )
        ],
      ),
    );
  }
}
