// ignore_for_file: unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  // saving user data
  Future saveUserData(String fullname, String email, String password) async {
    return await userCollection.doc(uid).set({
      "fullName": fullname,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
      "password": password,
    });
  }

  // getting user data
  Future getUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // get user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  // create a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  // getting the chats
  getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  // getting group admin
  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  // getting group members
  getGroupMembers(String groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  // search for group
  searchByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  // checking if user if in group
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join/exit
  Future toggleGroupJoin(
      String groupId, String userName, String groupName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    // if user in group then remove them
    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection('messages').add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData["message"],
      "recentMessageSender": chatMessageData["sender"],
      "recentMessageTime": chatMessageData["time"].toString(),
    });
  }
}
