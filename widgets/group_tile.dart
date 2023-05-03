// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ziom/pages/chat_page.dart';
import 'package:ziom/widgets/widgets.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupTile(
      {super.key,
      required this.userName,
      required this.groupId,
      required this.groupName});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ChatPage(
              groupName: widget.groupName,
              groupId: widget.groupId,
              userName: widget.userName,
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(widget.groupName),
          subtitle: Text("join as ${widget.userName}"),
        ),
      ),
    );
  }
}
