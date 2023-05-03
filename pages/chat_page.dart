// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String groupName;
  final String groupId;
  final String userName;
  const ChatPage(
      {super.key,
      required this.groupName,
      required this.groupId,
      required this.userName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(child: Text("chat page here")),
    );
  }
}
